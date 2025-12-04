import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  /// New Password
  Rx<TextEditingController> passwordCon = TextEditingController().obs;
  RxBool passwordValidation = true.obs;
  RxString passwordError = "".obs;

  /// Confirm Password
  Rx<TextEditingController> confirmPasswordCon = TextEditingController().obs;
  RxBool confirmPasswordValidation = true.obs;
  RxString confirmPasswordError = "".obs;

  RxBool disableButton = true.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void checkDisableButton() {
    disableButton.value = !(passwordCon.value.text.trim().isNotEmpty && confirmPasswordCon.value.text.trim().isNotEmpty);
  }

  bool validate() {
    if (passwordCon.value.text.trim().isEmpty) {
      passwordError.value = "Please enter new password";
      passwordValidation.value = false;
    }
    if (confirmPasswordCon.value.text.trim().isEmpty) {
      confirmPasswordError.value = "Please confirm password";
      confirmPasswordValidation.value = false;
    } else if (confirmPasswordCon.value.text.trim() != passwordCon.value.text.trim()) {
      confirmPasswordError.value = "Password does not match";
      confirmPasswordValidation.value = false;
    }

    return passwordValidation.isTrue && confirmPasswordValidation.isTrue;
  }
}
