import 'package:book_my_table_app/view/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_custom_color.dart';
import '../../widgets/sliver_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var searchField = Stack(
      children: [
        AppTextField(
          controller: con.searchCon.value,
          hintText: "Search for restaurant, cuisine or a dish",
          contentPadding: EdgeInsets.symmetric(vertical: defaultPadding).copyWith(left: defaultPadding * 2),
          padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding / 2),
          fillColor: customColors(context).whiteColor,
          textInputAction: .done,
          border: OutlineInputBorder(
            borderRadius: .circular(defaultRadius),
            borderSide: BorderSide(color: customColors(context).textPrimaryBlack),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: .circular(defaultRadius),
            borderSide: BorderSide(color: customColors(context).kPrimaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: .circular(defaultRadius),
            borderSide: BorderSide(color: customColors(context).kPrimaryColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: .circular(defaultRadius),
            borderSide: BorderSide(color: customColors(context).textPrimaryBlack),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: .circular(defaultRadius),
            borderSide: BorderSide(color: customColors(context).textError),
          ),
        ),

        Padding(
          padding: const .only(left: defaultPadding * 1.5, top: defaultPadding * 1.5),
          child: SvgPicture.asset(AppAssets.searchIcon, width: 16.sp),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: customColors(context).surfaceColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,

          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            slivers: [
              //* LOCATION & NOTIFICATION
              /*       SliverToBoxAdapter(
                child: Container(
                  color: customColors(context).surfaceColor,
                  padding: const EdgeInsets.all(defaultPadding).copyWith(right: defaultPadding / 4, bottom: defaultPadding / 2),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      /// HEADER
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Location",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: customColors(context).textPrimaryBlack, fontSize: 12.sp),
                              ).paddingOnly(left: 3),
                              (defaultPadding / 4).verticalSpace,
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 15.sp, color: customColors(context).kPrimaryColor),
                                  (defaultPadding / 4).horizontalSpace,

                                  Text(
                                    "San Francisco, CA",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: customColors(context).whiteColor, fontSize: 15.sp),
                                  ),
                                  (defaultPadding / 5).horizontalSpace,

                                  Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: customColors(context).textPrimaryBlack),
                                ],
                              ),
                            ],
                          ),

                          /// Notification
                          AppIconButton(onPressed: () {}, icon: SvgPicture.asset(AppAssets.notificationIcon)),
                        ],
                      ),
                    ],
                  ),
                ),
              ), */

              /// SEARCH BAR
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  maxHeight: 110.h,
                  minHeight: 110.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const .vertical(bottom: Radius.circular(defaultRadius * 2)),
                      boxShadow: [BoxShadow(color: Colors.black.withCtmOpacity(0.6), blurRadius: 8, spreadRadius: 1, offset: const Offset(0, -2))],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: customColors(context).surfaceColor,
                            borderRadius: .vertical(bottom: .circular(defaultRadius * 2.4)),
                          ),
                        ),
                        Align(alignment: .bottomRight, child: SvgPicture.asset(AppAssets.homeBackground)),
                        Align(
                          alignment: .centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              // color: customColors(context).surfaceColor,
                              borderRadius: .vertical(bottom: .circular(defaultRadius * 2.4)),
                            ),
                            child: Column(
                              children: [
                                5.verticalSpace,

                                /// HEADER
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text(
                                          "Location",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: customColors(context).textPrimaryBlack, fontSize: 12.sp),
                                        ).paddingOnly(left: 3),
                                        (defaultPadding / 4).verticalSpace,
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined, size: 15.sp, color: customColors(context).kPrimaryColor),
                                            (defaultPadding / 4).horizontalSpace,

                                            Text(
                                              "San Francisco, CA",
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: customColors(context).whiteColor, fontSize: 15.sp),
                                            ),
                                            (defaultPadding / 5).horizontalSpace,

                                            Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: customColors(context).textPrimaryBlack),
                                          ],
                                        ),
                                      ],
                                    ),

                                    /// Notification
                                    AppIconButton(onPressed: () {}, icon: SvgPicture.asset(AppAssets.notificationIcon)),
                                  ],
                                ).paddingSymmetric(horizontal: defaultPadding),

                                //* SEARCH FIELD
                                searchField,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// OTHER WIDGETS
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    // Special Offers
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          "Special Offers",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: customColors(context).whiteColor, fontSize: 18.sp),
                        ).paddingSymmetric(horizontal: defaultPadding).paddingOnly(top: defaultPadding * 1.5, bottom: defaultPadding),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400, color: customColors(context).kPrimaryColor, fontSize: 12.sp),
                          ),
                        ).paddingOnly(top: defaultPadding / 1.5, right: defaultPadding / 3),
                      ],
                    ),
                    ...List.generate(10, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2).copyWith(top: 0),
                        height: 100.h,
                        decoration: BoxDecoration(color: customColors(context).surfaceColor, borderRadius: .circular(defaultRadius)),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
