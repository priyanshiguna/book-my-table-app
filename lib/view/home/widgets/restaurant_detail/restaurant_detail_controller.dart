import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController with GetTickerProviderStateMixin {
  RxBool isLiked = false.obs;
  Rx<ScrollController> scrollController = ScrollController().obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
  }
}
