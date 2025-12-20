import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../exports.dart';
import '../../../packages/click_effect.dart';

class BottombarTile extends StatelessWidget {
  final void Function()? onTap;
  final String image;

  final String title;
  final bool? isSelected;

  const BottombarTile({super.key, required this.onTap, required this.image, required this.title, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 1.5, horizontal: defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: isSelected == true ? [BoxShadow(color: Theme.of(context).primaryColor.withCtmOpacity(0.2), blurRadius: 10)] : null),
                child: SvgPicture.asset(image),
              ),
              if (!isValEmpty(title)) ...[
                (defaultPadding / 3).verticalSpace,
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected == true ? AppColors.whiteColor : AppColors.textSecondaryBlack, // ignore: deprecated_member_use
                    fontWeight: isSelected == true ? FontWeight.w500 : FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
