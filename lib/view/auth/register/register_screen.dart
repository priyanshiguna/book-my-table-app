import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController con = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: true, systemNavigationBarColor: Theme.of(context).primaryColor),
      child: Obx(
        () => Scaffold(
          body: ListView(
            physics: RangeMaintainingScrollPhysics(),
            padding: EdgeInsets.all(0).copyWith(top: MediaQuery.of(context).padding.top + (defaultPadding * 2)),
            children: [
              Column(
                children: [
                  Text(
                    "Create Account",
                    style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
                  ),
                  (defaultPadding / 1.2).verticalSpace,
                  Text(
                    "Fill your information below or register\nwith your social account.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
                  ),
                  (defaultPadding * 1.5).verticalSpace,

                  /// Name Field
                  AppTextField(
                    title: "Name",
                    hintText: "Enter Name",
                    padding: EdgeInsets.only(bottom: defaultPadding * 2),
                  ),

                  /// Email Field
                  AppTextField(
                    title: "Email",
                    hintText: "Enter Email",
                    padding: EdgeInsets.only(bottom: defaultPadding * 2),
                  ),

                  /// Password Field
                  AppTextField(
                    title: "Password",
                    hintText: "Enter Password",
                    padding: EdgeInsets.only(bottom: defaultPadding * 2),
                    obscureText: con.isPasswordVisible.value,
                    suffixIcon: UiUtils.togglePasswordIcon(
                      context,
                      con.isPasswordVisible.value,
                      onTap: () {
                        con.isPasswordVisible.value = !con.isPasswordVisible.value;
                      },
                    ),
                  ),

                  /// Confirm Password Field
                  AppTextField(
                    title: "Confirm Password",
                    hintText: "Confirm Password",
                    padding: EdgeInsets.only(bottom: defaultPadding * 1.2),
                    obscureText: con.isConfirmPasswordVisible.value,
                    suffixIcon: UiUtils.togglePasswordIcon(
                      context,
                      con.isConfirmPasswordVisible.value,
                      onTap: () {
                        con.isConfirmPasswordVisible.value = !con.isConfirmPasswordVisible.value;
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: defaultPadding),

              Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: con.agreeToTerms.value,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Theme.of(context).scaffoldBackgroundColor,
                      onChanged: (val) {
                        con.agreeToTerms.value = !con.agreeToTerms.value;
                      },
                    ),
                  ),

                  Text(
                    "Agree with ",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Terms & Condition",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
                  ),
                ],
              ).paddingOnly(left: defaultPadding / 2),

              (defaultPadding * 1.4).verticalSpace,

              AppButton(
                title: "Sign Up",
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  Get.toNamed(AppRoutes.completeProfileScreen);
                },
              ).paddingOnly(bottom: defaultPadding * 2),

              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding / 2),
                child: Row(
                  children: [
                    Expanded(child: UiUtils.divider(context)),
                    Text("Or Sign up with", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack)),
                    Expanded(child: UiUtils.divider(context)),
                  ],
                ),
              ),

              Row(
                spacing: defaultPadding * 1.4,
                mainAxisAlignment: MainAxisAlignment.center,
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

              /// Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textPrimaryBlack, fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap, enableFeedback: true),
                    child: Text(
                      " Sign In",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).whiteColor, fontSize: 12.sp),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
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
