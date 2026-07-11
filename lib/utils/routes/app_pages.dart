import 'package:get/get.dart';

import '../../exports.dart';
import '../../view/auth/login/login_screen.dart';
import '../../view/auth/login/widgets/change_password/change_password_screen.dart';
import '../../view/auth/login/widgets/forgot_password/forgot_password_screen.dart';
import '../../view/auth/login/widgets/verify_code/verify_code_screen.dart';
import '../../view/auth/register/register_screen.dart';
import '../../view/auth/register/widgets/complete_profile/complete_profile_screen.dart';
import '../../view/bottombar/bottombar_screen.dart';
import '../../view/home/widgets/book_table/book_table_screen.dart';
import '../../view/home/widgets/restaurant_detail/restaurant_detail_screen.dart';
import '../../view/home/widgets/review_summary/review_summary_screen.dart';
import '../../view/splash/splash_screen.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.registerScreen, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.completeProfileScreen, page: () => CompleteProfileScreen()),
    GetPage(name: AppRoutes.changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.verifyCodeScreen, page: () => VerifyCodeScreen()),

    GetPage(name: AppRoutes.bottombarScreen, page: () => BottombarScreen()),
    GetPage(name: AppRoutes.restaurantDetailScreen, page: () => RestaurantDetailScreen()),
    GetPage(name: AppRoutes.bookATableScreen, page: () => BookTableScreen()),
    GetPage(name: AppRoutes.reviewSummaryScreen, page: () => ReviewSummaryScreen()),
  ];
}
