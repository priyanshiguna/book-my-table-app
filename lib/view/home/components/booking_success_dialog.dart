import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        leading: UiUtils.backIcon(
          iconColor: AppColors.kPrimaryColor,
          onPressed: () {
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),

              // Success checkmark circle
              Container(
                width: 100.w,
                height: 100.w,
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.black,
                  size: 50.sp,
                ),
              ),

              SizedBox(height: 24.h),

              // Success Title message
              Text(
                "Successfully\nReserved Your Table !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),

              SizedBox(height: 16.h),

              // Reservation ID text
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14.sp, color: Colors.white60),
                  children: [
                    const TextSpan(text: "Reservation ID : "),
                    const TextSpan(
                      text: "RSV5456",
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36.h),

              // 2-Column Info Grid
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoTile("Name", "Esther Howard"),
                        defaultPadding.verticalSpace,
                        _buildInfoTile("Time", "17:00 PM"),
                      ],
                    ),
                  ),
                  defaultPadding.horizontalSpace,
                  // Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoTile("Date", "Jan 04, 2024"),
                        defaultPadding.verticalSpace,
                        _buildInfoTile("No. of Guests", "04"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding.w, vertical: 12.h),
          child: AppButton(
            title: "View Bookings",
            onPressed: () {
              UiUtils.toast("Navigating to Bookings...");
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white54,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
