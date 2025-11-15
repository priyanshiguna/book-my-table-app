import 'package:get/get.dart';

class AppStrings {
  /// HOW TO USE: Text(AppStrings.appName);

  static RxString appName = "".obs; //? This Variable fill in BaseController

  // Commons
  static String noInternetAvailable = "No Internet available";
  static String logoutString = "Are you sure you want to logout?";
  static String exitAppString = "Are you sure you want to quit the application?";
  static String deleteAccountString = "Are you sure you want to delete your account?";

  /// Auth flow
  static String continueWithGoogle = "Continue with Google";
  static String continueWithApple = "Continue with Apple";
}
