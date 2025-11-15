import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../exports.dart';

class BaseController extends GetxController {
  late PackageInfo packageInfo;

  @override
  void onReady() async {
    super.onReady();
    await getPackageInfo().then((returnPkgInfo) {
      packageInfo = returnPkgInfo;
      AppStrings.appName.value = returnPkgInfo.appName;
    });
  }
}
