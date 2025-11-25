import 'package:book_my_table_app/res/app_custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static Widget backIcon() => const Icon(Icons.arrow_back, size: 25);

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
      child: Center(child: Text("+91", style: AppTextStyle.textFieldStyle(Get.context!))),
    ).paddingOnly(left: 8),
  );

  static Widget togglePasswordIcon(BuildContext context, bool isPasswordVisible, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility, size: 20, color: customColors(context).kPrimaryColor),
  );
}
