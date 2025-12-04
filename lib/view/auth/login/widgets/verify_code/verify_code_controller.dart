import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeController extends GetxController {
  RxString email = ''.obs;

  Rx<TextEditingController> pinController = TextEditingController().obs;
  RxBool pinValidate = true.obs;
  int maxPinLength = 4;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['email'].runtimeType == String) {
        email.value = Get.arguments['email'];
      }
    }
  }
}
