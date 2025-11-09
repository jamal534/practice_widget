import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/approute/approute.dart';


class MyApp extends StatelessWidget {


  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.locale?.languageCode == 'ar';
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFFFFFFF),
            useMaterial3: true,
          ),
          getPages: AppRoute.route,
          transitionDuration: const Duration(milliseconds: 200),
          navigatorKey: Get.key,
          initialRoute: AppRoute.loginScreen,
        );
      },
    );
  }
}
