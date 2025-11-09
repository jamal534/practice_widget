import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/network_response.dart';

Future<String?> GetToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("userToken");
}

class NetworkCaller {
  //final int timeoutDuration = 10;
  final int timeoutDuration = 80;
  String? token;

  // GET method
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log('GET Request: $url');
    log('GET Token: $token');
    try {
      token = await GetToken();
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST method
  Future<ResponseData> postRequest(
      String url, {
        Map<String, dynamic>? body,
        String? token,
      }) async {
    log('POST Request: $url');
    log('Request Body: ${jsonEncode(body)}');
    log('Token: $token');
    token = await GetToken();
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
}

ResponseData _handleResponse(Response response) {
  log('Response Status: ${response.statusCode}');
  log('Response Body: ${response.body}');

  final decodedResponse = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (decodedResponse['success'] == true) {
      return ResponseData(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodedResponse['result'],
        errorMessage: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse['message'] ?? 'Unknown error occurred',
      );
    }
  } else if (response.statusCode == 400) {
    return ResponseData(
      isSuccess: false,
      statusCode: response.statusCode,
      responseData: decodedResponse,
      errorMessage: _extractErrorMessages(decodedResponse['errorSources']),
    );
  } else if (response.statusCode == 500) {
    return ResponseData(
      isSuccess: false,
      statusCode: response.statusCode,
      responseData: decodedResponse,
      errorMessage:
      decodedResponse['message'] ?? 'An unexpected error occurred!',
    );
  } else {
    return ResponseData(
      isSuccess: false,
      statusCode: response.statusCode,
      responseData: decodedResponse,
      errorMessage: decodedResponse['message'] ?? 'An unknown error occurred',
    );
  }
}

ResponseData _handleError(dynamic error) {
  log('Request Error: $error');

  if (error is ClientException) {
    return ResponseData(
      isSuccess: false,
      statusCode: 500,
      responseData: '',
      errorMessage: 'Network error occurred. Please check your connection.',
    );
  } else if (error is TimeoutException) {
    return ResponseData(
      isSuccess: false,
      statusCode: 408,
      responseData: '',
      errorMessage: 'Request timeout. Please try again later.',
    );
  } else {
    return ResponseData(
      isSuccess: false,
      statusCode: 500,
      responseData: '',
      errorMessage: 'Unexpected error occurred.',
    );
  }
}

// Extract error messages for status 400
String _extractErrorMessages(dynamic errorSources) {
  if (errorSources is List) {
    return errorSources
        .map((error) => error['message'] ?? 'Unknown error')
        .join(', ');
  }
  return 'Validation error';
}