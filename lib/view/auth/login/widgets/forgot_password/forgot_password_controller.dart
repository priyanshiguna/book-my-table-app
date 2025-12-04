import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  Rx<TextEditingController> emailCon = TextEditingController().obs;
  RxBool emailValidation = true.obs;
  RxString emailError = "".obs;
}
