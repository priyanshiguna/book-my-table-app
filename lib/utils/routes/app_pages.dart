import 'package:get/get.dart';

import '../../exports.dart';
import '../../view/auth/login/login_screen.dart';
import '../../view/splash/splash_screen.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
  ];
}
