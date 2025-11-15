import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../exports.dart';

class UiUtils {
  static double appButtonHeight = 48.w;
  static double bottomBarHeight = 85;

  static double bottomBarHeightWithPadding(BuildContext context) => MediaQuery.of(context).padding.bottom + bottomBarHeight + defaultPadding * 1.2;

  static Future toast(String? message) async {
    FToast fToast = FToast();
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    return Fluttertoast.showToast(msg: message ?? "", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0);
  }

  static SystemUiOverlayStyle systemUiOverlayStyle({Color? statusBarColor, Brightness? statusBarIconBrightness, Brightness? statusBarBrightness, bool? reverse = false}) {
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent, // <-- SEE HERE
      statusBarIconBrightness: statusBarIconBrightness ?? (Get.isDarkMode ? Brightness.light : Brightness.dark), //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: statusBarBrightness ?? (Get.isDarkMode ? Brightness.dark : Brightness.light), //<-- For iOS SEE HERE (dark icons)
    );
  }

  static Widget backIcon() => const Icon(Icons.arrow_back, size: 25);

  static Widget menuIcon() => const Icon(Icons.menu, size: 25);

  static Widget actionIcon() => const Icon(Icons.more_vert, size: 25);
}
