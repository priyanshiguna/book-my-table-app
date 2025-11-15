import 'dart:async';

import '../../exports.dart';
import '../../utils/common_enums.dart';
import '../../widgets/snackbar_helper.dart';

class ApiUtils {
  ApiUtils._();

  static String defaultTitle = "Default Title";

  //* =-=-=-=-=-=-> After Logout API <-=-=-=-=-=-=- *//
  static Future<void> logoutAndCleanAllUserData() async {
    // if (Get.currentRoute != AppRoutes.mobileLoginView) {
    //   Get.offAllNamed(AppRoutes.mobileLoginView);
    // }
    //
    // flutterLocalNotificationsPlugin.cancelAll();

    deleteCacheDir();

    await LocalStorage.clearLocalStorage();

    printWarning("<-=-=-=-=-=-= DELETE TCM TOKEN =-=-=-=-=-=-=->");
    // await FirebaseMessaging.instance.deleteToken();
  }

  static void showSnackOnAPIMess(String? message, {double? bottomSpacing, double? timeLimitInSeconds, SnackBarType snackBarType = SnackBarType.complete, void Function()? onComplete}) {
    if (!isValEmpty(message)) {
      SnackBarHelper.showOnChangeStatus(
        title: message,
        timeLimitInSeconds: timeLimitInSeconds,
        snackbarType: snackBarType,
        bottomSpacing: bottomSpacing ?? (UiUtils.appButtonHeight + defaultPadding * 2),
        onComplete: onComplete,
      );
    } else {
      printErrors(type: "showSnackOnAPIMess Function", errText: "API 'message' is Val Empty");
    }
  }
}
