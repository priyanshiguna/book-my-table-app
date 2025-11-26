import 'package:book_my_table_app/view/auth/register/widgets/complete_profile/complete_profile_screen.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../view/auth/logins/login_screen.dart';
import '../../view/auth/register/register_screen.dart';
import '../../view/splash/splash_screen.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.registerScreen, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.completeProfileScreen, page: () => CompleteProfileScreen()),
    //
  ];
}
