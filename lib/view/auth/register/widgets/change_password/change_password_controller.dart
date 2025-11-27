import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  /// New Password
  Rx<TextEditingController> newPasswordCon = TextEditingController().obs;
  RxBool newPasswordValidation = true.obs;
  RxString newPasswordError = "".obs;

  /// Confirm Password
  Rx<TextEditingController> confirmPasswordCon = TextEditingController().obs;
  RxBool confirmPasswordValidation = true.obs;
  RxString confirmPasswordError = "".obs;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
}
