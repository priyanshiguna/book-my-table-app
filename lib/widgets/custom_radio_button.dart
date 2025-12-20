import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';
import '../packages/click_effect.dart';
import '../res/app_custom_color.dart';
import '../utils/common_enums.dart';

class CustomRadioButton extends StatelessWidget {
  final String? title;
  final RadioButtonType radioButtonType;
  final RxBool isSelected;
  final double? buttonSize;
  final double? borderSpacing;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;
  final bool? showDoneIcon;
  final CustomAlign buttonAlign;
  final bool? isExpanded;

  const CustomRadioButton({
    super.key,
    this.title,
    this.radioButtonType = RadioButtonType.filled,
    required this.isSelected,
    this.buttonSize,
    this.borderSpacing,
    this.onPressed,
    this.titleStyle,
    this.showDoneIcon,
    this.buttonAlign = CustomAlign.start,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final AnimatedDefaultTextStyle animatedDefaultTextStyle = AnimatedDefaultTextStyle(
      duration: defaultDuration,
      style:
          titleStyle ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: isSelected.isTrue ? FontWeight.w600 : FontWeight.w500,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withCtmOpacity(isSelected.isTrue ? 1 : 0.4),
            fontSize: 14.sp,
          ),
      child: Text(title ?? ""),
    );
    return ClickEffect(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (buttonAlign == CustomAlign.start || buttonAlign == CustomAlign.startTitle) ...[
            Expanded(child: animatedDefaultTextStyle),
            8.horizontalSpace,
          ],
          AppRadioButton(
            isSelected: isSelected,
            radioButtonType: radioButtonType,
            buttonSize: buttonSize,
            borderSpacing: borderSpacing,
            showDoneIcon: showDoneIcon,
          ),
          if (buttonAlign == CustomAlign.end || buttonAlign == CustomAlign.endTitle) ...[
            8.horizontalSpace,
            Flexible(child: animatedDefaultTextStyle),
          ],
        ],
      ).paddingSymmetric(vertical: defaultPadding / 2),
    );
  }
}

class AppRadioButton extends StatelessWidget {
  final RxBool isSelected;
  final double? buttonSize;
  final VoidCallback? onPressed;
  final RadioButtonType radioButtonType;
  final Color? color;
  final double? borderSpacing;
  final bool? showDoneIcon;

  const AppRadioButton({
    super.key,
    required this.isSelected,
    this.buttonSize,
    this.onPressed,
    this.radioButtonType = RadioButtonType.filled,
    this.color,
    this.borderSpacing,
    this.showDoneIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return newMethod(context);
    }
    return AppIconButton(
      onPressed: onPressed ?? () {},
      size: buttonSize != null ? (buttonSize! * 1.3) : 30,
      icon: newMethod(context),
    );
  }

  Widget newMethod(BuildContext context) {
    switch (radioButtonType) {
      case RadioButtonType.outline:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: size,
          width: size,
          padding: const EdgeInsets.all(5.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected.isFalse ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
            border: Border.all(
              color: (isSelected.isFalse ? Theme.of(context).secondaryHeaderColor : Colors.transparent),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected.isFalse ? Colors.transparent : Colors.white,
            ),
          ),
        );

      case RadioButtonType.filled:
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Container(
            height: size,
            width: size,
            padding: EdgeInsets.all(borderSpacing ?? 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: isSelected.isTrue ? (color ?? Theme.of(context).primaryColor) : Theme.of(context).primaryColor, width: 1.3),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: isSelected.isTrue ? (color ?? Theme.of(context).primaryColor) : Colors.transparent,
              child: showDoneIcon == true
                  ? Center(
                      child: SvgPicture.asset(
                        AppAssets.doneSmall,
                        color: isSelected.isTrue ? Theme.of(context).primaryColor : Colors.transparent, // ignore: deprecated_member_use
                      ),
                    )
                  : const SizedBox.square(),
            ),
          ),
        );

      case RadioButtonType.done:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected.isFalse ? Colors.transparent : customColors(context).kPrimaryColor,
            border: Border.all(
              color: color ?? (isSelected.isFalse ? customColors(context).kPrimaryColor : Colors.transparent),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.done_rounded,
              size: 14,
              color: isSelected.isTrue ? customColors(context).whiteColor : Colors.transparent, // ignore: deprecated_member_use
            ),
          ),
        );
    }
  }

  double get size => buttonSize ?? 17.h;
}
