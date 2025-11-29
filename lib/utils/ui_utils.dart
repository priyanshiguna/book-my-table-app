import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:book_my_table_app/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../exports.dart';

class UiUtils {
  static double appButtonHeight = 48.w;
  static double bottomBarHeight = 85;
  static double appButtonHight = 48.w;

  static double bottomBarHeightWithPadding(BuildContext context) => MediaQuery.of(context).padding.bottom + bottomBarHeight + defaultPadding * 1.2;

  static Future toast(String? message) async {
    FToast fToast = FToast();
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    return Fluttertoast.showToast(msg: message ?? "", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0);
  }

  static SystemUiOverlayStyle systemUiOverlayStyle({bool? isReverse, Color? statusBarColor, Brightness? statusBarIconBrightness, Brightness? statusBarBrightness, Color? systemNavigationBarColor}) {
    isReverse = (isReverse ?? Get.isDarkMode);
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent, // <-- SEE HERE
      statusBarIconBrightness: statusBarIconBrightness ?? (isReverse == true ? Brightness.light : Brightness.dark), //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: statusBarBrightness ?? (isReverse == true ? Brightness.dark : Brightness.light), //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: systemNavigationBarColor ?? Colors.transparent,
    );
  }


  static Widget backIcon({VoidCallback? onPressed, Color? iconColor}) => Center(
    child: AppIconButton(
      size: 48,
      icon: SvgPicture.asset(
        AppAssets.backArrowIcon,
        height: 20,
        width: 20,
        colorFilter: iconColor != null ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null,
      ),
      onPressed: onPressed ?? () => Get.back(),
    ),
  );

  static Widget menuIcon() => const Icon(Icons.menu, size: 25);

  static Widget actionIcon() => const Icon(Icons.more_vert, size: 25);

  static Widget fadeSwitcherWidget({Duration? duration, required Widget child}) {
    return AnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: child,
        );
      },
      //? Anytime child key passing deferent.
      child: child,
    );
  }

  static Widget countryCodeWidget({VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 40 + (AppTextStyle.textFieldStyle(Get.context!).fontSize ?? 0),
      child: Align(
        alignment: .bottomLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("+91", style: AppTextStyle.textFieldStyle(Get.context!).copyWith(color: customColors(Get.context!).whiteColor.withAppOpacity(.7))).paddingOnly(bottom: defaultPadding / 3),
            Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: customColors(Get.context!).textPrimaryBlack).paddingOnly(bottom: defaultPadding / 3),
          ],
        ),
      ),
    ),
  );

  static Widget togglePasswordIcon(BuildContext context, bool isPasswordVisible, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, size: 20, color: customColors(context).kPrimaryColor),
  );

  static Widget divider(BuildContext context) {
    return Divider(color: customColors(context).textPrimaryBlack, thickness: 1, endIndent: defaultPadding / 2, indent: defaultPadding);
  }
}
