import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../packages/cached_network_image/cached_network_image.dart';
import '../../packages/click_effect.dart';
import '../../res/app_custom_color.dart';
import '../../res/empty_element.dart';
import '../../widgets/sliver_delegate.dart';
import 'components/header_widget.dart';
import 'components/restaurant_card.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final searchField = Stack(
      children: [
        AppTextField(
          controller: con.searchCon.value,
          hintText: "Search for restaurant, cuisine or a dish",
          contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding).copyWith(left: defaultPadding * 2),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding / 2),
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

    return Obx(
      () => Scaffold(
        backgroundColor: customColors(context).surfaceColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,

            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withCtmOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: customColors(context).surfaceColor,
                              borderRadius: const .vertical(bottom: .circular(defaultRadius * 2.4)),
                            ),
                          ),
                          Align(alignment: .bottomRight, child: SvgPicture.asset(AppAssets.homeBackground)),
                          Align(
                            alignment: .centerLeft,
                            child: Container(
                              decoration: const BoxDecoration(
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
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: customColors(context).whiteColor,
                                                  fontSize: 15.sp,
                                                ),
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
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: customColors(context).kPrimaryColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ).paddingOnly(top: defaultPadding / 1.5, right: defaultPadding / 3),
                        ],
                      ),

                      // Banner Widget
                      _buildBannerWidget(),

                      // Cuisines
                      Padding(
                        padding: const .only(top: defaultPadding * 1.3, bottom: defaultPadding),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            if (con.cuisineList.isNotEmpty) ...[
                              const HeaderWidget(
                                title: "Cuisines",
                              ).paddingOnly(left: defaultPadding),
                              (defaultPadding / 1.2).verticalSpace,

                              // Cuisines List
                              SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: .horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      con.cuisineList.length,
                                      (index) => _buildCuisineCard(
                                        title: con.cuisineList[index].name ?? "",
                                        imageUrl: con.cuisineList[index].imageUrl ?? "",
                                        onPressed: () {},
                                      ).paddingOnly(right: defaultPadding / 1.2),
                                    ),
                                  ],
                                ).paddingOnly(left: defaultPadding),
                              ).paddingOnly(bottom: defaultPadding * 1.3),
                            ],

                            const HeaderWidget(
                              title: "Popular Restaurants",
                            ).paddingOnly(left: defaultPadding, bottom: defaultPadding),

                            /// Restaurants List
                            if (con.restaurantList.isNotEmpty)
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: con.restaurantList.length,
                                separatorBuilder: (context, index) => defaultPadding.verticalSpace,
                                itemBuilder: (context, index) {
                                  final restaurant = con.restaurantList[index];

                                  return RestaurantCard(
                                    imageUrl: restaurant.imageUrl,
                                    name: restaurant.name,
                                    rating: restaurant.rating,
                                    time: restaurant.time,
                                    type: restaurant.type,
                                    address: restaurant.address,
                                    isWishListed: restaurant.isWishListed,
                                    onPressed: () {},
                                    OnWishListPressed: () {
                                      restaurant.isWishListed.value = !(restaurant.isWishListed.value);
                                    },
                                  );
                                },
                              )
                            else
                              const EmptyElement(
                                title: "No Restaurants Found",
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerWidget() {
    return AspectRatio(
      aspectRatio: 15 / 7,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: customColors(context).kPrimaryColor),
          borderRadius: .circular(defaultRadius * 1.4),
        ),
        child: Stack(
          children: [
            /// Banner Image
            Container(
              decoration: BoxDecoration(
                color: customColors(context).lightGrey,
                borderRadius: .circular(defaultRadius * 1.3),
                image: const DecorationImage(image: AssetImage(AppAssets.bannerImage), fit: BoxFit.cover),
              ),
            ),

            Positioned(
              top: defaultPadding / 1.7,
              left: defaultPadding / 1.1,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  /// Weekend Offer Tag
                  Container(
                    padding: const .symmetric(horizontal: defaultPadding / 1.4, vertical: defaultPadding / 3.4),
                    decoration: BoxDecoration(
                      borderRadius: .circular(defaultRadius * 4),
                      color: customColors(context).whiteColor,
                    ),
                    child: Text(
                      "Weekend Offers",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ),

                  /// Get 20% Off Text
                  (defaultPadding / 2).verticalSpace,
                  Text(
                    "Get Special Offer",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 19.sp,
                      color: customColors(context).whiteColor,
                      fontWeight: .w600,
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Up to  ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: customColors(context).whiteColor,
                        ),
                      ).paddingOnly(top: defaultPadding / 3),
                      Text(
                        "30%",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 32.sp,
                          fontWeight: .w600,
                          color: customColors(context).whiteColor,
                        ),
                      ),
                    ],
                  ),

                  /// Book Now
                  AppButton(
                    title: "Book Now",
                    height: 24.h,
                    width: 80.w,
                    fontSize: 10.sp,
                    onPressed: () {},
                  ).paddingOnly(top: defaultPadding / 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuisineCard({required String title, required String imageUrl, VoidCallback? onPressed}) {
    return ClickEffect(
      onTap: onPressed,
      child: SizedBox(
        height: 28.h,
        width: 85.w,
        child: ClipRRect(
          borderRadius: .circular(defaultRadius * 3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // background image using your AppNetworkImage
              AppNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),

              // dark overlay for readable text
              Container(color: Colors.black.withOpacity(0.45)),

              // centered title
              Center(
                child: Text(
                  title,
                  style: AppTextStyle.appButtonStyle(context).copyWith(
                    fontSize: 15.sp,
                    color: customColors(context).whiteColor,
                    fontWeight: .w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
