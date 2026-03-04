import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../res/app_custom_color.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors(context).backgroundDark,
        borderRadius: BorderRadius.circular(defaultRadius * 2.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Header: "Notification" + "2 New" badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 1.2).copyWith(top: defaultPadding * 1.5, bottom: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: customColors(context).kPrimaryColor,
                    fontSize: 20.sp,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 1.2, vertical: defaultPadding / 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius * 3),
                    color: customColors(context).whiteColor,
                    border: Border.all(color: customColors(context).kPrimaryColor, width: 1.2),
                  ),
                  child: Text(
                    "2 New",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: customColors(context).textError,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Notification Items
          Flexible(
            child: Scrollbar(
              thumbVisibility: true,
              radius: const Radius.circular(defaultRadius),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                physics: const RangeMaintainingScrollPhysics(),
                separatorBuilder: (context, index) => Divider(color: customColors(context).textPrimaryBlack.withOpacity(0.3), thickness: 0.5, indent: defaultPadding, endIndent: defaultPadding),
                itemBuilder: (context, index) {
                  return _NotificationTile(
                    title: "Table Booked Successfully!",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                    time: "${index + 1}h",
                    isHighlighted: false,
                  );
                },
              ),
            ),
          ),

          (defaultPadding).verticalSpace,
        ],
      ),
    ).paddingOnly(top: defaultPadding);
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isHighlighted;

  const _NotificationTile({
    required this.title,
    required this.description,
    required this.time,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 1.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Bell Icon in circle
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: customColors(context).surfaceColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.foodIcon,
                width: 22.w,
                height: 22.w,
                colorFilter: ColorFilter.mode(
                  customColors(context).kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          (defaultPadding / 1.2).horizontalSpace,

          /// Title + Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: customColors(context).whiteColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    (defaultPadding / 2).horizontalSpace,
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: customColors(context).textPrimaryBlack,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                (defaultPadding / 4).verticalSpace,
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: customColors(context).textPrimaryBlack,
                    fontSize: 12.sp,
                    height: 1.4,
                    decoration: isHighlighted ? TextDecoration.underline : null,
                    decorationColor: isHighlighted ? customColors(context).kPrimaryColor : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
