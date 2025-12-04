import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;

  RxBool agreeToTerms = false.obs;
  RxBool disableButton = true.obs;

  //* Email Field
  Rx<TextEditingController> emailCon = TextEditingController().obs;
  RxBool emailValidation = true.obs;
  RxString emailError = "".obs;

  //* Password Field
  Rx<TextEditingController> passwordCon = TextEditingController().obs;
  RxBool passwordValidation = true.obs;
  RxString passwordError = "".obs;

  //* Check Disable Button
  void checkDisableButton() {
    if (emailCon.value.text.isNotEmpty && passwordCon.value.text.isNotEmpty) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }

  bool validate() {
    if (!GetUtils.isEmail(emailCon.value.text.trim())) {
      emailValidation.value = false;
      emailError.value = "Please enter a valid email";
    }

    return emailValidation.isTrue;
  }
}
