import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  RxBool disableButton = true.obs;
  RxString imageUrlOrPath = ''.obs;

  //* Name Field
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValidation = true.obs;
  RxString nameError = "".obs;

  //* Phone Number Field
  Rx<TextEditingController> phoneCon = TextEditingController().obs;
  RxBool phoneValidation = true.obs;
  RxString phoneError = "".obs;

  //* Gender Field
  Rx<TextEditingController> genderCon = TextEditingController().obs;
  RxBool genderValidation = true.obs;
  RxString genderError = "".obs;

  //* Check Disable Button
  void checkDisableButton() {
    if (nameCon.value.text.isNotEmpty && phoneCon.value.text.isNotEmpty && genderCon.value.text.isNotEmpty) {
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
    if (phoneCon.value.text.trim().isEmpty) {
      phoneError.value = "Please enter your phone number";
      phoneValidation.value = false;
    } else if (phoneCon.value.text.trim().length != 10) {
      phoneError.value = "Please enter a valid phone number";
      phoneValidation.value = false;
    }

    if (genderCon.value.text.trim().isEmpty) {
      genderError.value = "Please select your gender";
      genderValidation.value = false;
    }

    return nameValidation.isTrue && phoneValidation.isTrue && genderValidation.isTrue;
  }
}
