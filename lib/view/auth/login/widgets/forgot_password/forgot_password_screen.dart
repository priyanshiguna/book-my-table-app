import 'package:book_my_table_app/res/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_custom_color.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController con = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: MyAppBar(),
        body: ListView(
          padding: .symmetric(horizontal: defaultPadding),
          children: [
            Text(
              "Forget Password",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
            ),
            (defaultPadding / 1.2).verticalSpace,
            Text(
              "Please enter the your email",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
            ),
            (defaultPadding * 3.5).verticalSpace,

            /// Name Field
            AppTextField(
              title: "Email",
              hintText: "Enter Email",
              controller: con.emailCon.value,
              validation: con.emailValidation.value,
              errorMessage: con.emailError.value,
              textInputAction: TextInputAction.done,
              padding: .only(bottom: UiUtils.appButtonHeight * 2),
              onChanged: (value) {
                con.emailCon.refresh();
              },
            ),

            AppButton(
              title: "Sent OTP",
              disableButton: con.emailCon.value.text.isEmpty,
              onPressed: () {
                FocusScope.of(context).unfocus();

                Get.toNamed(AppRoutes.verifyCodeScreen, arguments: {"email": con.emailCon.value.text.trim()});
              },
            ).paddingOnly(bottom: defaultPadding * 2),
          ],
        ),
      ),
    );
  }
}
