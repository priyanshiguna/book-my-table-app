import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_bar.dart';
import '../../../../../res/app_custom_color.dart';
import 'verify_code_controller.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key});

  final VerifyCodeController con = Get.put(VerifyCodeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: MyAppBar(),
        body: ListView(
          padding: const .symmetric(horizontal: defaultPadding),
          children: [
            Text(
              "Verify Code",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
            ),
            (defaultPadding / 1.2).verticalSpace,
            Text(
              "Plese entetr the code we just sent to",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
            ),
            Text(
              con.email.value,
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).kPrimaryColor),
            ),
            (defaultPadding * 2).verticalSpace,

            //* OTP Field
            Pinput(
              controller: con.pinController.value,
              selectionControls: EmptyTextSelectionControls(),
              defaultPinTheme: defaultPinTheme,
              length: con.maxPinLength,
              keyboardType: TextInputType.number,
              obscureText: false,
              isCursorAnimationEnabled: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(con.maxPinLength)],
              onChanged: (_) {
                con.pinValidate.value = true;
                con.pinController.refresh();
              },
              showCursor: true,
              cursor: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 20,
                  height: 2,
                  margin: const EdgeInsets.only(bottom: defaultPadding / 2),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: borderRadius,
                  border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                ),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: customColors(context).textFieldBorder, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              followingPinTheme: defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration!.copyWith(borderRadius: borderRadius)),
              submittedPinTheme: defaultPinTheme.copyWith(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: customColors(context).textFieldBorder),
                decoration: defaultPinTheme.decoration!.copyWith(borderRadius: borderRadius),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(border: Border.all(color: customColors(context).textError)),
              onClipboardFound: (value) {
                if (value is int) {
                  con.pinController.value.setText(value);
                }
              },
              onCompleted: (value) async {
                //* VERIFY PIN API
                // await AuthRepository.verifyPinAPI(isLoader: con.isLoader, pin: int.tryParse(con.pinController.value.text.trim()) ?? 0);
              },
            ).paddingOnly(bottom: defaultPadding * 3),

            //* Resend Code
            Text(
              "Don’t receive OTP ?",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).whiteColor),
            ),
            Text(
              "Resend code",
              textAlign: TextAlign.center,
              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 13.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).kPrimaryColor, decoration: TextDecoration.underline),
            ).paddingSymmetric(vertical: defaultPadding / 2.4),

            //* Sent OTP CTA
            AppButton(
              title: "Sent OTP",
              disableButton: con.pinController.value.text.length < con.maxPinLength,
              padding: const EdgeInsets.only(top: defaultPadding),
              onPressed: () {
                FocusScope.of(context).unfocus();

                Get.toNamed(AppRoutes.changePasswordScreen);
              },
            ).paddingOnly(bottom: defaultPadding * 2),
          ],
        ),
      ),
    );
  }

  PinTheme get defaultPinTheme {
    return PinTheme(
      width: 47,
      height: 47,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
      textStyle: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(color: customColors(Get.context!).surfaceColor, borderRadius: borderRadius),
    );
  }

  BorderRadiusGeometry get borderRadius {
    return BorderRadius.circular(6);
  }
}
