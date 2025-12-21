import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../res/app_custom_color.dart';

class WishlistIconButton extends StatelessWidget {
  final RxBool isWishListed;
  final VoidCallback? onPressed;

  const WishlistIconButton({super.key, this.onPressed, required this.isWishListed});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppIconButton(
        onPressed: onPressed,
        backgroundColor: customColors(context).whiteColor,
        icon: SvgPicture.asset(
          isWishListed.isTrue ? AppAssets.heartFillIcon : AppAssets.heartIcon,
          height: 24,
        ),
      ),
    );
  }
}
