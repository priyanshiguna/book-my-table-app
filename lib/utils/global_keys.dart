import 'package:book_my_table_app/controller/base_controller.dart';
import 'package:book_my_table_app/controller/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// Helper method to get current route //! It's not working Perfectly...
String getCurrentRoute(GlobalKey<NavigatorState>? navigatorKey) {
  if (navigatorKey != null && navigatorKey.currentState == null) {
    return 'Navigator not found';
  }
  final route = ModalRoute.of(navigatorKey!.currentState!.context)?.settings.name;
  return route ?? 'Unknown route';
}

/// Base Controller
final BaseController baseCon = Get.find<BaseController>();

/// Network Controller
final NetworkController networkCon = Get.find<NetworkController>();


