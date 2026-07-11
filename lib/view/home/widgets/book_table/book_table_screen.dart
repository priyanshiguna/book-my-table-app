import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'book_table_controller.dart';

class BookTableScreen extends StatelessWidget {
  BookTableScreen({super.key});

  final BookTableController con = Get.put(BookTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Book a Table",
        centerTitle: true,
        backIconColor: AppColors.kPrimaryColor,
      ),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date & Time Header Row
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.calenderIcon,
                      colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Date & Time",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                    const Spacer(),
                    // Month/Year Selection Pill
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.kPrimaryColor, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Month Dropdown
                            PopupMenuButton<int>(
                              onSelected: con.updateMonth,
                              offset: Offset(0, 30.h),
                              color: const Color(0xFF222222),
                              itemBuilder: (context) => List.generate(12, (index) {
                                return PopupMenuItem<int>(
                                  value: index + 1,
                                  child: Text(
                                    con.monthNames[index],
                                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                  ),
                                );
                              }),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    con.selectedMonthName,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.kPrimaryColor,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Text(
                                "|",
                                style: TextStyle(color: Colors.white38, fontSize: 13.sp),
                              ),
                            ),
                            // Year Dropdown
                            PopupMenuButton<int>(
                              onSelected: con.updateYear,
                              offset: Offset(0, 30.h),
                              color: const Color(0xFF222222),
                              itemBuilder: (context) => List.generate(con.years.length, (index) {
                                final year = con.years[index];
                                return PopupMenuItem<int>(
                                  value: year,
                                  child: Text(
                                    "$year",
                                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                  ),
                                );
                              }),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${con.selectedYear.value}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.kPrimaryColor,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                defaultPadding.verticalSpace,

                // Calendar Days of Week Header
                Row(
                  children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12.h),

                // Calendar Days Grid
                Obx(() {
                  final int days = con.daysInMonth;
                  final int padding = con.startPadding;
                  final int totalCells = days + padding;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalCells,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      if (index < padding) {
                        return const SizedBox.shrink();
                      }

                      final int _currentYear = DateTime.now().year;
                      final int day = index - padding + 1;

                      // or actual today if the selected month & year match current local time.
                      bool isPast = false;
                      bool isToday = false;

                      if (con.selectedYear.value < _currentYear) {
                        isPast = true;
                      } else if (con.selectedYear.value == _currentYear && con.selectedMonth.value < 1) {
                        isPast = true;
                      } else if (con.selectedYear.value == _currentYear && con.selectedMonth.value == 1) {
                        if (day < 12) {
                          isPast = true;
                        } else if (day == 12) {
                          isToday = true;
                        }
                      } else {
                        final now = DateTime.now();
                        if (con.selectedYear.value == now.year && con.selectedMonth.value == now.month) {
                          if (day < now.day) {
                            isPast = true;
                          } else if (day == now.day) {
                            isToday = true;
                          }
                        }
                      }

                      return Obx(() {
                        final bool isSelected = day == con.selectedDay.value;
                        return GestureDetector(
                          onTap: isPast ? null : () => con.selectDay(day),
                          child: Container(
                            decoration: isSelected
                                ? const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF2C2C2C),
                                  )
                                : isToday
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF1E1E1E),
                                    border: Border.all(color: Colors.white54, width: 1.5),
                                  )
                                : BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                            child: Center(
                              child: Text(
                                day.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : isToday
                                      ? AppColors.whiteColor
                                      : isPast
                                      ? Colors.black26
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
                defaultPadding.verticalSpace,

                // Time Selection Wheel Card
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hour Scroll Wheel
                      SizedBox(
                        width: 60.w,
                        child: CupertinoPicker(
                          scrollController: con.hourController,
                          itemExtent: 30.h,
                          onSelectedItemChanged: (index) {
                            con.selectedHour.value = index + 1;
                          },
                          selectionOverlay: const SizedBox.shrink(),
                          children: List.generate(12, (index) {
                            final int val = index + 1;
                            return Center(
                              child: Obx(() {
                                final isSelected = con.selectedHour.value == val;
                                return Text(
                                  "$val",
                                  style: TextStyle(
                                    fontSize: isSelected ? 22.sp : 18.sp,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? Colors.white : Colors.white38,
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).paddingSymmetric(horizontal: 12.w),
                      // Minute Scroll Wheel
                      SizedBox(
                        width: 60.w,
                        child: CupertinoPicker(
                          scrollController: con.minuteController,
                          itemExtent: 30.h,
                          onSelectedItemChanged: (index) {
                            con.selectedMinute.value = index;
                          },
                          selectionOverlay: const SizedBox.shrink(),
                          children: List.generate(60, (index) {
                            return Center(
                              child: Obx(() {
                                final isSelected = con.selectedMinute.value == index;
                                return Text(
                                  index.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: isSelected ? 22.sp : 18.sp,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? Colors.white : Colors.white38,
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // AM/PM Scroll Wheel
                      SizedBox(
                        width: 60.w,
                        child: CupertinoPicker(
                          scrollController: con.periodController,
                          itemExtent: 30.h,
                          onSelectedItemChanged: (index) {
                            con.selectedPeriod.value = index == 0 ? "AM" : "PM";
                          },
                          selectionOverlay: const SizedBox.shrink(),
                          children: List.generate(2, (index) {
                            final String val = index == 0 ? "AM" : "PM";
                            return Center(
                              child: Obx(() {
                                final isSelected = con.selectedPeriod.value == val;
                                return Text(
                                  val,
                                  style: TextStyle(
                                    fontSize: isSelected ? 22.sp : 18.sp,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? Colors.white : Colors.white38,
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                defaultPadding.verticalSpace,

                // Guests Header Row
                Row(
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      color: AppColors.kPrimaryColor,
                      size: 22.sp,
                    ),
                    8.horizontalSpace,
                    Text(
                      "Guests",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Guests Counter Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: con.decrementGuests,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 200.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: Obx(
                          () => Text(
                            "${con.guestCount.value}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: con.incrementGuests,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,

                // Booking Details Summary
                Text(
                  "Booking ${con.guestCount.value} Guests ${con.selectedDay.value} ${con.selectedMonthName} \$${con.totalPrice}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                defaultPadding.verticalSpace,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding.w, vertical: 12.h).copyWith(top: defaultPadding / 2),
          child: AppButton(
            title: "Proceed next",
            onPressed: () {
              Get.toNamed(AppRoutes.reviewSummaryScreen);
            },
          ),
        ),
      ),
    );
  }
}
