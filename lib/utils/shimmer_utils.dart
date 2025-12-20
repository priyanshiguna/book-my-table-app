import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../exports.dart';

class ShimmerUtils {
  ShimmerUtils._();

  static Widget shimmer({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    Color? mainHighlightColor,
    bool isShowShimmer = true,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isShowShimmer == true
          ? Shimmer.fromColors(
              baseColor: baseColor ?? Theme.of(Get.context!).primaryColor.withCtmOpacity(1),
              highlightColor: (highlightColor?.withCtmOpacity(0.1) ?? Theme.of(Get.context!).scaffoldBackgroundColor),
              child: child,
            )
          : child,
    );
  }

  static Container d({Color? color}) {
    return Container(
      height: 1,
      color: color ?? Colors.white.withCtmOpacity(0.2),
    );
  }

  static Widget shimmerContainer({double? height, double? width, BorderRadiusGeometry? borderRadius, Widget? child, Decoration? decoration, Color? color}) => Container(
    height: height,
    width: width,
    decoration:
        decoration ??
        BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(50),
          color: color ?? Theme.of(Get.context!).primaryColor.withCtmOpacity(0.1),
        ),
    child: child,
  );

  static Widget loadingShimmerWidget({bool showImageBox = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: ShimmerUtils.shimmer(
        baseColor: Theme.of(Get.context!).primaryColor.withCtmOpacity(.74),
        child: ShimmerUtils.shimmerContainer(
          borderRadius: BorderRadius.circular(defaultRadius),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8.h),
            child: Row(
              children: [
                if (showImageBox) ...[
                  ShimmerUtils.shimmer(
                    child: ShimmerUtils.shimmerContainer(
                      height: 55,
                      width: 55,
                      borderRadius: BorderRadius.circular(defaultRadius / 2),
                    ),
                  ),
                  defaultPadding.horizontalSpace,
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerUtils.shimmer(
                      child: ShimmerUtils.shimmerContainer(
                        height: 10.h,
                        width: 100.w,
                        borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                      ),
                    ),
                    (defaultPadding / 2).verticalSpace,
                    ShimmerUtils.shimmer(
                      child: ShimmerUtils.shimmerContainer(
                        height: 10.h,
                        width: Get.width / 2,
                        borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget userTileShimmerWidget({bool showImageBox = true}) {
    return Row(
      children: [
        if (showImageBox) ...[
          ShimmerUtils.shimmer(
            child: ShimmerUtils.shimmerContainer(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(Get.context!).primaryColor.withCtmOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(defaultRadius / 2),
            ),
          ),
          defaultPadding.horizontalSpace,
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 10.h,
                width: 100.w,
                borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
              ),
            ),
            (defaultPadding / 2).verticalSpace,
            ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 10.h,
                width: Get.width / 2,
                borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget radioLoadingShimmerWidget(BuildContext context, {bool withScroll = false, int simmerCount = 14}) {
    return ListView(
      shrinkWrap: !withScroll,
      physics: withScroll ? null : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        /*  Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ShimmerUtils.shimmer(
              child: ShimmerUtils.shimmerContainer(
                height: 12.h,
                width: 90.w,
                borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
              ),
            ),
          ),
        ), */
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: defaultPadding / 3),
          itemCount: simmerCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
              child: ShimmerUtils.shimmer(
                baseColor: Theme.of(Get.context!).primaryColor.withCtmOpacity(.74),
                child: ShimmerUtils.shimmerContainer(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding * 1.5, horizontal: defaultPadding),
                    child: Row(
                      children: [
                        ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(
                            height: 18.h,
                            width: 18.h,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withCtmOpacity(0.1)),
                            borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                          ),
                        ),
                        defaultPadding.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerUtils.shimmer(
                              child: ShimmerUtils.shimmerContainer(
                                height: 10.h,
                                width: 100.w,
                                borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                              ),
                            ),
                            (defaultPadding / 2).verticalSpace,
                            ShimmerUtils.shimmer(
                              child: ShimmerUtils.shimmerContainer(
                                height: 10.h,
                                width: Get.width * 0.45,
                                borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  static Widget mealShimmerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
      child: ShimmerUtils.shimmer(
        baseColor: Theme.of(Get.context!).primaryColor.withCtmOpacity(.74),
        child: ShimmerUtils.shimmerContainer(
          borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerUtils.shimmer(
                  child: ShimmerUtils.shimmerContainer(
                    height: 10.h,
                    width: 90.w,
                    borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                  ),
                ),
                (defaultPadding / 1.1).verticalSpace,
                ShimmerUtils.shimmer(
                  child: ShimmerUtils.shimmerContainer(
                    height: 1.h,
                    width: Get.width,
                    borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                  ),
                ),
                (defaultPadding / 1.1).verticalSpace,
                ShimmerUtils.shimmer(
                  child: ShimmerUtils.shimmerContainer(
                    height: 10.h,
                    width: Get.width / 2.2.w,
                    borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                  ),
                ),
                (defaultPadding / 1.4).verticalSpace,
                ShimmerUtils.shimmer(
                  child: ShimmerUtils.shimmerContainer(
                    height: 10.h,
                    width: Get.width / 3.w,
                    borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                  ),
                ),
                (defaultPadding / 1.4).verticalSpace,
                ShimmerUtils.shimmer(
                  child: ShimmerUtils.shimmerContainer(
                    height: 10.h,
                    width: Get.width / 1.8.w,
                    borderRadius: BorderRadius.circular(defaultRadius - (8 / 2)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget dewormingShimmer(BuildContext context) {
    return ShimmerUtils.shimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ShimmerUtils.shimmerContainer(
          borderRadius: BorderRadius.circular(defaultRadius),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerUtils.shimmerContainer(
                      height: 16.h,
                      width: Get.width / 3,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    ShimmerUtils.shimmerContainer(
                      height: 16.h,
                      width: Get.width / 3,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ],
                ),
                defaultPadding.verticalSpace,
                ShimmerUtils.shimmerContainer(
                  height: 1.h,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                defaultPadding.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerUtils.shimmerContainer(
                      height: 16.h,
                      width: Get.width / 5,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    ShimmerUtils.shimmerContainer(
                      height: 16.h,
                      width: Get.width / 5,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                  ],
                ),
                defaultPadding.verticalSpace,
                ShimmerUtils.shimmerContainer(
                  height: 1.h,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                (defaultPadding).verticalSpace,
                ShimmerUtils.shimmerContainer(
                  height: 16.h,
                  width: Get.width / 4,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const RangeMaintainingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: defaultPadding / 2,
                    mainAxisSpacing: defaultPadding / 2,
                    mainAxisExtent: 32.h,
                  ),
                  itemBuilder: (context, index) => ShimmerUtils.shimmerContainer(
                    height: 30.h,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
