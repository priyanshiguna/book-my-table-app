import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../exports.dart';
import '../res/app_custom_color.dart';
import '../utils/common_enums.dart';
import '../utils/global_context.dart';

class SnackBarHelper {
  SnackBarHelper._();

  static BuildContext get context => GlobalContext().globalContext;

  static void showOnChangeStatus({
    double? timeLimitInSeconds = 2.0,
    VoidCallback? onComplete,
    EdgeInsetsGeometry? margin,
    SnackBarType snackbarType = SnackBarType.complete,
    double? bottomSpacing,
    String? title,
    bool bottomSafeArea = false,
  }) {
    final RxDouble currentTimeLimit = 0.0.obs;
    final RxDouble timeLimitInSecond = (timeLimitInSeconds ?? 2.0).obs;
    final RxDouble minimumLimit = 0.08.obs;
    Timer? mainTimer;

    Color? typeColor() {
      switch (snackbarType) {
        case SnackBarType.complete:
          return customColors(context).buttonGreen;
        case SnackBarType.wrong:
          return Colors.redAccent;
        case SnackBarType.warning:
          return const Color.fromARGB(255, 234, 184, 37);
      }
    }

    void onStart() async {
      mainTimer?.cancel();

      currentTimeLimit.value = timeLimitInSecond.value;

      mainTimer = Timer.periodic(
        const Duration(milliseconds: 10),
        (timer) async {
          if (currentTimeLimit.value > minimumLimit.value) {
            currentTimeLimit.value -= 0.01; // Decrease by a smaller increment
          } else {
            currentTimeLimit.value = 0.0;
            timer.cancel();
            onComplete != null ? onComplete() : null;
          }
        },
      );
    }

    onStart();

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: timeLimitInSecond.toInt()),
          // width: Get.width - defaultPadding * 2,
          // padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          elevation: bottomSpacing == 0 ? 0 : null,
          margin:
              margin ??
              EdgeInsets.fromLTRB(
                defaultPadding,
                5.0,
                defaultPadding,
                (bottomSpacing ?? defaultPadding) + (bottomSafeArea ? MediaQuery.of(context).padding.bottom : 0),
              ),
          padding: EdgeInsets.zero,
          onVisible: () {},
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius * 1.5)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Container(
            color: typeColor()?.withOpacity(.1),
            child: Obx(
              () => ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(defaultRadius * 1.5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 1.2, horizontal: defaultPadding).copyWith(bottom: (defaultPadding / 1.2) - 4),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: typeColor(),
                            child: snackbarType == SnackBarType.warning
                                ? const Text("!")
                                : Icon(
                                    switch (snackbarType) {
                                      SnackBarType.wrong => Icons.close_rounded,
                                      SnackBarType.complete => Icons.done_rounded,
                                      SnackBarType.warning => Icons.close_rounded,
                                    },
                                    size: 17,
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              title ?? (snackbarType == SnackBarType.complete ? "Changes have been saved" : "Something went wrong"),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.titleStyle(context)?.copyWith(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      percent: ((currentTimeLimit.value * 100) / timeLimitInSecond.value) / 100,
                      lineHeight: 4,
                      backgroundColor: typeColor()?.withOpacity(.1),
                      progressColor: typeColor(),
                      barRadius: const Radius.circular(5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
