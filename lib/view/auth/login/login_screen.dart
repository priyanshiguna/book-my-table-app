import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
          body: ListView(
            physics: RangeMaintainingScrollPhysics(),
            padding: EdgeInsets.all(0).copyWith(top: MediaQuery.of(context).padding.top + (defaultPadding * 4)),
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        con.emailCon.value.text = "test@gmail.com";
                        con.passwordCon.value.text = "123456";
                        con.checkDisableButton();
                      }
                    },
                    child: Text(
                      "Welcome Back",
                      style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
                    ),
                  ),
                  (defaultPadding / 1.2).verticalSpace,
                  Text(
                    "Fill your information below or login\nwith your social account.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
                  ),
                  (defaultPadding * 3.5).verticalSpace,

                  /// Name Field
                  AppTextField(
                    title: "Email",
                    hintText: "Enter Email",
                    padding: .only(bottom: defaultPadding * 2),
                    controller: con.emailCon.value,
                    validation: con.emailValidation.value,
                    errorMessage: con.emailError.value,
                    onChanged: (_) {
                      con.emailValidation.value = true;
                      con.checkDisableButton();
                    },
                  ),

                  /// Confirm Password Field
                  AppTextField(
                    title: "Password",
                    hintText: "Enter Password",
                    padding: .only(bottom: defaultPadding * 1.2),
                    obscureText: con.isPasswordVisible.value,
                    suffixIcon: UiUtils.togglePasswordIcon(
                      context,
                      con.isPasswordVisible.value,
                      onTap: () {
                        con.isPasswordVisible.value = !con.isPasswordVisible.value;
                      },
                    ),
                    controller: con.passwordCon.value,
                    validation: con.passwordValidation.value,
                    errorMessage: con.passwordError.value,
                    onChanged: (_) {
                      con.passwordValidation.value = true;
                      con.checkDisableButton();
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: defaultPadding),

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.forgotPasswordScreen);
                },
                child: Align(
                  alignment: .centerRight,
                  child: Text(
                    "Forget Password ?",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
                  ).paddingOnly(right: defaultPadding, top: defaultPadding / 1.6, bottom: defaultPadding / 5),
                ),
              ),

              (defaultPadding * 1.8).verticalSpace,

              //* Login CTA
              AppButton(
                title: "Sign In",
                disableButton: con.disableButton.value,
                padding: .symmetric(horizontal: defaultPadding),
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  if (con.validate()) {
                    Get.toNamed(AppRoutes.completeProfileScreen);
                  }
                },
              ).paddingOnly(bottom: defaultPadding * 2),

              Padding(
                padding: const .only(bottom: defaultPadding / 2),
                child: Row(
                  children: [
                    Expanded(child: UiUtils.divider(context)),
                    Text("Or Log in with", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack)),
                    Expanded(child: UiUtils.divider(context)),
                  ],
                ),
              ),

              Row(
                spacing: defaultPadding * 1.4,
                mainAxisAlignment: .center,
                children: [
                  AppIconButton(
                    icon: SvgPicture.asset(AppAssets.appleSvg),
                    onPressed: () {
                      //? Apple Login Action
                    },
                  ),
                  AppIconButton(
                    icon: SvgPicture.asset(AppAssets.googleSvg),
                    onPressed: () {
                      //? Google Login Action
                    },
                  ),
                  AppIconButton(
                    icon: SvgPicture.asset(AppAssets.facebookSvg),
                    onPressed: () {
                      //? Facebook Login Action
                    },
                  ),
                ],
              ).paddingSymmetric(vertical: defaultPadding),

              //* Already have an account
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Create a new account?",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack, fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: ButtonStyle(padding: WidgetStateProperty.all(.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap, enableFeedback: true),
                    child: Text(
                      " Sign Up",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 12.sp),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.registerScreen);
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
