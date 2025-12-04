import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/app_strings.dart';
import '../../utils/color_print.dart';
import '../../utils/ui_utils.dart';
import '../../utils/utils.dart';


class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  Rx<ConnectivityResult> connectivityType = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Choose a primary result for backward-compatible state
      final ConnectivityResult primary = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateConnectionStatus(primary);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    printOkStatus(connectivityResult);

    connectivityType.value = connectivityResult;

    if (connectivityResult == ConnectivityResult.none) {
        Get.rawSnackbar(
        messageText: const Center(child: Text('PLEASE CONNECT TO THE INTERNET', style: TextStyle(color: Colors.white, fontSize: 14))),
        padding: const EdgeInsets.all(defaultPadding / 2),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.redAccent,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
    
      );
    } else {
      /* if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      } */

      updateAllController();
    }
  }

  void updateAllController() async {}
}

/// ***********************************************************************************
///                                 Check Internet Ability                            *
/// ***********************************************************************************

ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();

Future<bool> getConnectivityResult({BuildContext? context, bool showToast = true, RxBool? isLoader}) async {
  void showMess() {
    UiUtils.toast(AppStrings.noInternetAvailable);
    // if (context != null) {
    //   context.error(AppStrings.noInternetAvailable);
    // } else {
    //   UiUtils.toast(AppStrings.noInternetAvailable);
    // }
  }

  try {
    final List<ConnectivityResult> results = await connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)) {
      connectivityResult = results.isNotEmpty ? results.first : ConnectivityResult.none;
      return true;
    } else {
      isLoader?.value = false;

      if (showToast == true) {
        showMess();
      }
      return false;
    }
  } on PlatformException catch (e) {
    isLoader?.value = false;

    if (showToast == true) {
      showMess();
    }
    printErrors(type: "getConnectivityResult Function", errText: e);
    return false;
  }
}