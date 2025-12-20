import 'package:get/get.dart';

import '../../utils/local_storage.dart';
import '../../utils/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      navigation();
    });
  }

  void navigation() {
    if (!LocalStorage.accessToken.isNotEmpty) {
      Get.offAllNamed(AppRoutes.registerScreen);
    } else {
      // Get.offAllNamed(AppRoutes.dashboardScreen);
    }
  }
}
