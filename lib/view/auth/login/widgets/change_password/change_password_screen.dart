import 'package:book_my_table_app/res/app_bar.dart';
import 'package:book_my_table_app/view/auth/login/widgets/change_password/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_custom_color.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController con = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: MyAppBar(),
        body: Padding(
          padding: .symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Text(
                "Change Password",
                textAlign: TextAlign.center,
                style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
              ),
              (defaultPadding * 3.5).verticalSpace,

              /// New Password
              AppTextField(
                title: "Password",
                hintText: "Enter Password",
                controller: con.newPasswordCon.value,
                validation: con.newPasswordValidation.value,
                errorMessage: con.newPasswordError.value,
                padding: .only(bottom: defaultPadding * 2),
                obscureText: con.isPasswordVisible.value,
                suffixIcon: UiUtils.togglePasswordIcon(
                  context,
                  con.isPasswordVisible.value,
                  onTap: () {
                    con.isPasswordVisible.value = !con.isPasswordVisible.value;
                  },
                ),
              ),

              /// Confirm Password
              AppTextField(
                title: "Confirm Password",
                hintText: "Confirm Password",
                controller: con.confirmPasswordCon.value,
                validation: con.confirmPasswordValidation.value,
                errorMessage: con.confirmPasswordError.value,
                padding: .only(bottom: defaultPadding * 1.2),
                obscureText: con.isConfirmPasswordVisible.value,
                suffixIcon: UiUtils.togglePasswordIcon(
                  context,
                  con.isConfirmPasswordVisible.value,
                  onTap: () {
                    con.isConfirmPasswordVisible.value = !con.isConfirmPasswordVisible.value;
                  },
                ),
              ),
              AppButton(
                title: "Submit",
                padding: .only(top: defaultPadding * 2.5),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
              ).paddingOnly(bottom: defaultPadding * 2),
              Spacer(),

              /// Already have an account
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack, fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: ButtonStyle(padding: WidgetStateProperty.all(.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap, enableFeedback: true),
                    child: Text(
                      " Sign In",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 12.sp),
                    ),
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.loginScreen);
                    },
                  ),
                ],
              ).paddingOnly(bottom: defaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
