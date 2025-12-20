import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../utils/shimmer_utils.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? blurHash;
  final BoxFit? fit;
  final Color? backgroundColor;
  final Color? imageColor;
  final Color? imageBorderColor;
  final Alignment? alignment;
  final FilterQuality filterQuality;
  final BoxShape shape;
  final BlendMode? blendMode;
  final double? height;
  final double? width;
  final double? svgIconHeight;
  final double? svgIconWidth;
  final double? borderWidth;
  final double? emptyImageRadius;
  final double? indicatorSize;
  final double? indicatorStrokeWidth;
  final bool? showProgressIndicator;
  final Widget Function(BuildContext, String)? placeholder;
  final Duration? fadeInDuration;
  final VoidCallback? onTap;
  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? errorWidget;
  final bool? memCacheZero;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.blurHash,
    this.fit,
    this.height,
    this.width,
    this.svgIconHeight,
    this.svgIconWidth,
    this.backgroundColor,
    this.emptyImageRadius,
    this.imageBorderColor,
    this.alignment,
    this.filterQuality = FilterQuality.low,
    this.shape = BoxShape.rectangle,
    this.indicatorSize = 25.0,
    this.indicatorStrokeWidth,
    this.showProgressIndicator,
    this.onTap,
    this.fadeInDuration,
    this.fadeOutDuration,
    this.placeholderFadeInDuration,
    this.margin,
    this.padding,
    this.borderRadius,
    this.imageColor,
    this.borderWidth,
    this.blendMode,
    this.boxShadow,
    this.errorWidget,
    this.placeholder,
    this.memCacheZero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          clipBehavior: Clip.antiAlias,
          margin: padding,
          padding: margin,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: shape,
            borderRadius: borderRadius,
            boxShadow: _hasError.isFalse ? boxShadow : null,
            border: imageBorderColor != null ? Border.all(width: borderWidth ?? 1.0, color: imageBorderColor!) : null,
          ),
          child: !isValEmpty(imageUrl)
              ? Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                    shape: shape,
                    borderRadius: borderRadius,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imageUrl.toLowerCase().endsWith('.svg')
                      ? Center(
                          child: SvgPicture.network(
                            imageUrl,
                            height: svgIconHeight,
                            width: svgIconWidth,
                            fit: fit ?? BoxFit.contain,
                            color: imageColor,
                            placeholderBuilder: (context) => Center(
                              child: SizedBox(
                                height: indicatorSize ?? 25,
                                width: indicatorSize ?? 25,
                                child: Center(
                                  child: CircularProgressIndicator(strokeWidth: indicatorStrokeWidth ?? 2.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: imageUrl,
                          // alignment: alignment ?? Alignment.center,
                          fit: fit,
                          height: height,
                          width: width,
                          color: imageColor,
                          maxHeightDiskCache: 999,
                          maxWidthDiskCache: 999,
                          memCacheHeight: memCacheZero == true ? null : 999,
                          memCacheWidth: memCacheZero == true ? null : 999,
                          filterQuality: filterQuality,
                          fadeOutDuration: fadeOutDuration ?? const Duration(microseconds: 1),
                          fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 500),
                          progressIndicatorBuilder: (showProgressIndicator ?? false
                              ? (context, url, progress) {
                                  _hasError.value = false;
                                  return Center(
                                    child: SizedBox(
                                      height: indicatorSize,
                                      width: indicatorSize,
                                      child: Center(
                                        child: CircularProgressIndicator(strokeWidth: indicatorStrokeWidth ?? 2.0, value: progress.progress),
                                      ),
                                    ),
                                  );
                                }
                              : null),
                          placeholderFadeInDuration: placeholderFadeInDuration ?? const Duration(microseconds: 1),
                          placeholder:
                              placeholder ??
                              (showProgressIndicator ?? true
                                  ? (context, url) =>
                                        //?BlurHash image view not use because of not working properly
                                        /*  !isValEmpty(blurHash)
                        ? Container(
                            width: width,
                            height: height ?? Get.height * 0.225,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius ?? BorderRadius.circular(defaultRadius),
                              image: DecorationImage(
                                image: BlurHashImage(blurHash ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : */
                                        ShimmerUtils.shimmer(
                                          child: ShimmerUtils.shimmerContainer(
                                            width: width,
                                            height: height ?? Get.height * 0.225,
                                            borderRadius: borderRadius ?? BorderRadius.circular(defaultRadius),
                                          ),
                                        )
                                  : null),
                          errorWidget: (context, url, error) {
                            _hasError.value = true;
                            return Container(
                              height: height ?? Get.height * 0.225,
                              width: width,
                              color: Theme.of(context).iconTheme.color!.withAlpha(30),
                              padding: const EdgeInsets.all(defaultPadding * 2),
                              child: kDebugMode
                                  ? Center(
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: Colors.grey[800],
                                      ),
                                    )
                                  : null,
                            );
                          },
                        ),
                )
              : errorWidget ??
                    UiUtils.imageEmptyWidget(
                      radius: emptyImageRadius,
                      context,
                      height: Get.width * 0.3,
                      width: Get.width * 0.3,
                    ),
        ),
      ),
    );
  }

  RxBool get _hasError => false.obs;
}
