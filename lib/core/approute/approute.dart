import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:parctice_widget/feture/profile/presentation/profile_screen.dart';
import '../../feture/auth/presentation/login_screen.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String profileScreen = "/profileScreen";
  static List<GetPage> route = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: profileScreen, page: () => ProfileDetailsScreen()),
  ];
}
