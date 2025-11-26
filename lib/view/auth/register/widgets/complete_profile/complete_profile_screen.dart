import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_custom_color.dart';
import 'complete_profile_controller.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({super.key});

  final CompleteProfileController con = Get.put(CompleteProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: RangeMaintainingScrollPhysics(),
        padding: EdgeInsets.all(0).copyWith(top: MediaQuery.of(context).padding.top + (defaultPadding * 3)),
        children: [
          Column(
            children: [
              Text(
                "Complete Your Profile",
                style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 20.sp, color: customColors(context).whiteColor),
              ),
              (defaultPadding / 1.2).verticalSpace,
              Text(
                "Don't worry, only you can see your personal\ndata. No one else will be able to see it.",
                textAlign: TextAlign.center,
                style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 12.sp, height: 1.48, fontWeight: FontWeight.w400, color: customColors(context).textPrimaryBlack),
              ),
              (defaultPadding * 2).verticalSpace,

              /// Profile Image
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(color: customColors(context).surfaceColor, shape: BoxShape.circle),
                    padding: EdgeInsets.all(defaultPadding * 1.2),
                    child: SvgPicture.asset(AppAssets.profileIcon),
                  ),

                  Container(
                    height: 20.h,
                    width: 20.h,
                    margin: EdgeInsets.only(right: 4.w, bottom: 4.h),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                    child: Center(child: SvgPicture.asset(AppAssets.editSvg)),
                  ),
                ],
              ),

              /// Name Field
              AppTextField(
                title: "Name",
                hintText: "Enter Name",
                padding: EdgeInsets.only(bottom: defaultPadding * 2.3),
              ),

              /// Phone Number Field
              AppTextField(
                title: "Phone Number",
                hintText: "Enter Phone Number",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                prefixIcon: UiUtils.countryCodeWidget(),
                padding: EdgeInsets.only(bottom: defaultPadding * 2.3),
              ),

              /// Gender Field
              AppTextField(
                title: "Gender",
                hintText: "Select",
                textInputAction: TextInputAction.next,
                readOnly: true,
                suffixIcon: Align(alignment: Alignment.bottomRight, child: SvgPicture.asset(AppAssets.downArrowSvg)).paddingOnly(bottom: defaultPadding / 1.5),
                padding: EdgeInsets.only(bottom: defaultPadding * 2.3),
              ),
            ],
          ).paddingSymmetric(horizontal: defaultPadding),

          (defaultPadding / 1.2).verticalSpace,
          AppButton(
            title: "Complete Profile",
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
          ).paddingOnly(bottom: defaultPadding * 2),
        ],
      ),
    );
  }
}
