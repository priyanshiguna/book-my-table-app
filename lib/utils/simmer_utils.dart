import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'extensions/color_extensions.dart';

class SimmerUtils {
  SimmerUtils._();

  static Widget shimmer({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    bool isShowSimmer = true,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isShowSimmer == true
          ? Shimmer.fromColors(
              baseColor: baseColor ?? Theme.of(Get.context!).primaryColor.withAppOpacity(1),
              highlightColor: highlightColor?.withAppOpacity(0.1) ?? Theme.of(Get.context!).primaryColor.withAppOpacity(0.2),
              child: child,
            )
          : child,
    );
  }

  static Container d({Color? color}) {
    return Container(
      height: 1,
      color: color ?? Colors.white.withAppOpacity(0.2),
    );
  }

  static Widget simmerContainer({double? height, double? width, double? borderRadius, Widget? child, Decoration? decoration}) => Container(
    height: height,
    width: width,
    decoration:
        decoration ??
        BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
          color: Theme.of(Get.context!).primaryColor.withAppOpacity(0.1),
        ),
  );
}
