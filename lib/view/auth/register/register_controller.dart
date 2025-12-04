import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  RxBool agreeToTerms = false.obs;
  RxBool disableButton = true.obs;

  //* Name Field
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValidation = true.obs;
  RxString nameError = "".obs;

  //* Email Field
  Rx<TextEditingController> emailCon = TextEditingController().obs;
  RxBool emailValidation = true.obs;
  RxString emailError = "".obs;

  //* Password Field
  Rx<TextEditingController> passwordCon = TextEditingController().obs;
  RxBool passwordValidation = true.obs;
  RxString passwordError = "".obs;

  //* Confirm Password Field
  Rx<TextEditingController> confirmPasswordCon = TextEditingController().obs;
  RxBool confirmPasswordValidation = true.obs;
  RxString confirmPasswordError = "".obs;

  //* Check Disable Button
  void checkDisableButton() {
    if (nameCon.value.text.isNotEmpty && emailCon.value.text.isNotEmpty && passwordCon.value.text.isNotEmpty && confirmPasswordCon.value.text.isNotEmpty && agreeToTerms.value) {
      disableButton.value = false;
    } else {
      disableButton.value = true;
    }
  }

  bool validate() {
    if (nameCon.value.text.trim().isEmpty) {
      nameError.value = "Please enter your name";
      nameValidation.value = false;
    }
    if (emailCon.value.text.trim().isEmpty) {
      emailError.value = "Please enter your email";
      emailValidation.value = false;
    }
    if (passwordCon.value.text.trim().isEmpty) {
      passwordError.value = "Please enter your password";
      passwordValidation.value = false;
    }
    if (confirmPasswordCon.value.text.trim().isEmpty) {
      confirmPasswordError.value = "Please confirm password";
      confirmPasswordValidation.value = false;
    } else if (confirmPasswordCon.value.text.trim() != passwordCon.value.text.trim()) {
      confirmPasswordError.value = "Password does not match";
      confirmPasswordValidation.value = false;
    }

    return nameValidation.isTrue && emailValidation.isTrue && passwordValidation.isTrue && confirmPasswordValidation.isTrue;
  }
}
