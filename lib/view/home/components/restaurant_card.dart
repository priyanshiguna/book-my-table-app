import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../packages/cached_network_image/cached_network_image.dart';
import '../../../packages/click_effect.dart';
import '../../../res/app_custom_color.dart';
import 'wishlist_icon_button.dart';

class RestaurantCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final String? time;
  final String? type;
  final String? address;
  final VoidCallback? onPressed;
  final RxBool isWishListed;
  final VoidCallback? OnWishListPressed;

  const RestaurantCard({super.key, this.imageUrl, this.name, this.rating, this.time, this.type, this.address, this.onPressed, required this.isWishListed, this.OnWishListPressed});

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onPressed,
      child: Container(
        margin: const .symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: customColors(context).surfaceDark,
          borderRadius: .circular(defaultRadius * 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withCtmOpacity(.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                /// Image
                AppNetworkImage(
                  borderRadius: const .vertical(top: .circular(defaultRadius * 3)),
                  height: 150,
                  width: Get.width,
                  fit: .cover,
                  imageUrl: imageUrl ?? '',
                ).paddingOnly(bottom: defaultPadding),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      /// Name
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name ?? "-",
                              overflow: .ellipsis,
                              style: AppTextStyle.mediumStyle(context)?.copyWith(
                                color: customColors(context).whiteColor,
                                fontSize: 16.sp,
                                fontWeight: .w500,
                              ),
                            ).paddingOnly(right: defaultPadding),
                          ),

                          SvgPicture.asset(
                            AppAssets.starIcon,
                            height: 11.sp,
                            colorFilter: const ColorFilter.mode(Colors.yellow, .srcIn),
                          ).paddingOnly(right: defaultPadding / 2),
                          Text(
                            (rating ?? 0).toString(),
                            style: AppTextStyle.mediumStyle(context)?.copyWith(
                              color: customColors(context).whiteColor,
                              fontSize: 12.sp,
                              fontWeight: .w600,
                            ),
                          ),
                        ],
                      ),

                      (defaultPadding / 1.5).verticalSpace,

                      /// Time & Type
                      if (!isValEmpty(time) || !isValEmpty(type))
                        Row(
                          children: [
                            // Time
                            if (!isValEmpty(time)) ...[
                              SvgPicture.asset(
                                AppAssets.clockIcon,
                              ).paddingOnly(right: defaultRadius),
                              Text(
                                time ?? "-",
                                maxLines: 2,
                                overflow: .ellipsis,
                                style: AppTextStyle.mediumStyle(context)?.copyWith(
                                  color: customColors(context).textPrimaryBlack,
                                  fontSize: 12.sp,
                                ),
                              ),

                              (defaultPadding).horizontalSpace,
                            ],

                            // Type
                            if (!isValEmpty(type)) ...[
                              SvgPicture.asset(
                                AppAssets.foodIcon,
                                height: 12,
                              ).paddingOnly(right: defaultRadius),
                              Text(
                                type ?? "-",
                                maxLines: 2,
                                overflow: .ellipsis,
                                style: AppTextStyle.mediumStyle(context)?.copyWith(
                                  color: customColors(context).textPrimaryBlack,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ],
                        ).paddingOnly(bottom: defaultPadding / 2),

                      /// Address
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          SvgPicture.asset(AppAssets.locationSVG).paddingOnly(right: defaultRadius),
                          Expanded(
                            child: Text(
                              address ?? "-",
                              maxLines: 2,
                              overflow: .ellipsis,
                              style: AppTextStyle.mediumStyle(context)?.copyWith(
                                color: customColors(context).textPrimaryBlack,
                                fontSize: 12.sp,
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

            // Wishlist Button
            Positioned(
              top: defaultPadding,
              right: defaultPadding,
              child: WishlistIconButton(
                isWishListed: isWishListed,
                onPressed: OnWishListPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
