import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/network_controller.dart';
import '../../exports.dart';
import 'enum/bottombar_enum.dart';

class BottombarController extends GetxController with WidgetsBindingObserver {
  Rx<BottombarTab> selectedBottomTab = BottombarTab.mainline.obs;

  RxBool isLoggedIn = true.obs;

  Timer? tapDebounce;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['bottomBarTabType'].runtimeType == BottombarTab) {
        selectedBottomTab.value = Get.arguments['bottomBarTabType'];
      }
    }
    /** Use In Lifecycle State */
    WidgetsBinding.instance.addObserver(this);
  }

  Timer? bgTimer;
  RxBool isBgTimeOver = false.obs;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        printOkStatus('App Resumed');

        if (bgTimer?.isActive ?? false) {
          bgTimer?.cancel();
        }

        printData(key: "isBgTimeOver", value: isBgTimeOver);

        if (isBgTimeOver.isTrue) {
          isBgTimeOver.value = false;

          if (isRegistered<NetworkController>()) {
            // Get.find<NetworkController>().updateAllController();
          }
        }

        break;

      case AppLifecycleState.inactive:
        // printYellow('App Inactive');
        break;

      case AppLifecycleState.paused:
        printWhite('App Paused');
        timerBackgroundStart();
        break;

      case AppLifecycleState.detached:
        // printCancel('App Detached');
        break;

      case AppLifecycleState.hidden:
        // printWarning('App hidden');
        break;
    }
  }

  Future timerBackgroundStart() async {
    bgTimer = Timer(
      const Duration(seconds: 30),
      () async {
        if (bgTimer?.isActive ?? false) {
          bgTimer?.cancel();
        }

        isBgTimeOver.value = true;

        printData(key: "isBgTimeOver", value: isBgTimeOver);
      },
    );
  }

  BottombarTab previousTab = BottombarTab.sme;

  void onBottomBarTap(BottombarTab bottombarTab, {bool? hapticFeedback = false}) {
    //? Single touch
    if (selectedBottomTab.value != bottombarTab) {
      //? Manage Haptic Feedback (vibration)
      if (hapticFeedback == true) {
        HapticFeedback.mediumImpact();
      }

      //? Manage swipe transition
      if (bottombarTab.id > selectedBottomTab.value.id) {
        // Switch to right'
        isLoggedIn.value = true;
      } else if (bottombarTab.id < selectedBottomTab.value.id) {
        // Switch to left'
        isLoggedIn.value = false;
      }

      previousTab = selectedBottomTab.value;
      selectedBottomTab.value = bottombarTab;

      tapActions();
    } else {
      //? Multiple touches
    }
  }

  Future<void> tapActions() async {
    if (tapDebounce?.isActive ?? false) tapDebounce?.cancel();
    tapDebounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        switch (selectedBottomTab.value) {
          /// Home
          case BottombarTab.mainline:
            break;

          /// Appointments
          case BottombarTab.sme:
            break;

          /// Customer
          case BottombarTab.history:
            break;

          /// Profile
          case BottombarTab.news:
            break;
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    printOkStatus("On close bottombar");

    //** Use In Lifecycle State */
    WidgetsBinding.instance.removeObserver(this);
  }
}
