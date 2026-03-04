import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/base_controller.dart';
import 'exports.dart';
import 'utils/global_context.dart';
import 'widgets/stretch_scroll_behavior.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    // LocalStorage.clearLocalStorage();
    // LocalStorage.printLocalStorageData();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          enableLog: false,
          title: AppStrings.appName.value,
          debugShowCheckedModeBanner: false,
          scrollBehavior: ScrollBehaviorModified(),
          initialBinding: LazyBinding(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightMode(context),
          darkTheme: AppTheme.darkMode(context),
          defaultTransition: Transition.cupertino,
          navigatorKey: GlobalContext.instance.navigatorKey,
          getPages: AppPages.pages, // GetPages is a class that holds all the routes of the app
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}

class LazyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
    printData(key: "Get.put", value: BaseController);
  }
}
