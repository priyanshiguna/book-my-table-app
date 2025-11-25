import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: true, systemNavigationBarColor: Theme.of(context).primaryColor),
      child: Obx(
        () => Scaffold(
          body: Padding(
            padding: EdgeInsets.all(defaultPadding).copyWith(top: MediaQuery.of(context).padding.top + (defaultPadding * 3)),
            child: Column(
              children: [
                Text(
                  "Create Account",
                  style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
                ),
                (defaultPadding / 1.2).verticalSpace,
                Text(
                  "Fill your information below or register\nwith your social account.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
                ),
                defaultPadding.verticalSpace,

                /// Name Field
                AppTextField(
                  title: "Name",
                  hintText: "Enter Name",
                  padding: EdgeInsets.only(bottom: defaultPadding * 2.4),
                ),

                /// Password Field
                AppTextField(
                  title: "Email",
                  hintText: "Enter Email",
                  padding: EdgeInsets.only(bottom: defaultPadding * 2.4),
                ),

                /// Confirm Password Field
                AppTextField(
                  title: "Password",
                  hintText: "Enter Password",
                  padding: EdgeInsets.only(bottom: defaultPadding * 2.4),
                  obscureText: con.isPasswordVisible.value,
                  suffixIcon: UiUtils.togglePasswordIcon(
                    context,
                    con.isPasswordVisible.value,
                    onTap: () {
                      con.isPasswordVisible.value = !con.isPasswordVisible.value;
                    },
                  ),
                ),

                defaultPadding.verticalSpace,

                AppButton(
                  title: "Sign Up",
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
