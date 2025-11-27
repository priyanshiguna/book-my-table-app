import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController con = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: true, systemNavigationBarColor: Theme.of(context).primaryColor),
      child: Scaffold(
        body: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 20.0, end: 1.0),
          builder: (context, value, child) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(AppAssets.splashBg, height: Get.height),
                  AnimatedOpacity(opacity: value == 20 ? 0 : 1, duration: const Duration(milliseconds: 700), child: SvgPicture.asset(AppAssets.appLogoSvg, height: 100)),

                  Positioned(
                    bottom: UiUtils.appButtonHeight,
                    child: AnimatedOpacity(
                      opacity: value == 20 ? 0 : 1,
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        "“Apke Liye,\nAapka Pasandida Table“",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
