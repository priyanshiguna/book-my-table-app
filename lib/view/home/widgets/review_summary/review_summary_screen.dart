import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../packages/cached_network_image/cached_network_image.dart';
import '../../../../res/app_bar.dart';
import '../../components/booking_success_dialog.dart';
import 'review_summary_controller.dart';

class ReviewSummaryScreen extends StatelessWidget {
  ReviewSummaryScreen({super.key});

  final ReviewSummaryController con = Get.put(ReviewSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: MyAppBar(
        title: "Review Summary",
        centerTitle: true,
        elevation: 0,
        color: Colors.transparent,
        backIconColor: AppColors.kPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Card Container
              Row(
                children: [
                  // Rounded Restaurant Image
                  AppNetworkImage(
                    imageUrl: con.restaurantImageUrl,
                    fit: .cover,
                    borderRadius: .circular(12.r),
                    width: 80.h,
                    height: 80.h,
                  ),
                  defaultPadding.horizontalSpace,
                  // Restaurant Name and Address
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          con.restaurantName,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.whiteColor),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.kPrimaryColor,
                              size: 16.sp,
                            ),
                            4.horizontalSpace,
                            Expanded(
                              child: Text(
                                con.restaurantAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              defaultPadding.verticalSpace,
              const Divider(color: Colors.white12, thickness: 1),
              defaultPadding.verticalSpace,

              // Booking details
              _buildDetailRow("Name", con.name),
              defaultPadding.verticalSpace,
              _buildDetailRow("Reservation ID", con.reservationId),
              defaultPadding.verticalSpace,
              _buildDetailRow("Phone Number", con.phoneNumber),
              defaultPadding.verticalSpace,
              _buildDetailRow("Booking Date", con.bookingDate),

              defaultPadding.verticalSpace,
              const Divider(color: Colors.white12, thickness: 1),
              defaultPadding.verticalSpace,

              // Guests and Payment details
              _buildDetailRow("Number of Guests", con.numberOfGuests),
              defaultPadding.verticalSpace,
              _buildDetailRow("Booking Payment", con.bookingPayment, isPayment: true),
              defaultPadding.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding.w, vertical: 12.h),
          child: AppButton(
            title: "Proceed Payment",
            onPressed: () {
              Get.dialog(const BookingSuccessDialog(), useSafeArea: false);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPayment = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isPayment ? FontWeight.bold : FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
