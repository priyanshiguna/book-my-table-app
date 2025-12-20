import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';
import '../packages/marquee_widget/marquee_widget.dart';
import '../utils/common_enums.dart';
import '../utils/extensions/color_extensions.dart';
import 'app_custom_color.dart';

class AppButton extends StatefulWidget {
  final ButtonType? buttonType;
  final ImageAlign? imageAlign;
  final String? title;
  final TextStyle? titleStyle;
  final double? height;
  final bool? flexibleHeight;
  final double? width;
  final bool? flexibleWidth;
  final Duration? duration;
  final IconData? icon;
  final Color? loaderColor;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? highlightColor;
  final Gradient? gradient;
  final String? image;
  final Color? imageColor;
  final double? imageSize;
  final double? imageSpacing;
  final double? fontSize;
  final Widget? child;
  final Widget? topLayerWidget;
  final bool? disableButton;
  final bool? loader;
  final bool? enableFeedback;
  final bool? useMarqueeTitle;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final Function(bool)? onHighlightChanged;

  const AppButton({
    super.key,
    this.title,
    this.titleStyle,
    this.buttonType = ButtonType.elevated,
    this.imageAlign,
    this.height,
    this.flexibleHeight = false,
    this.width,
    this.flexibleWidth = false,
    this.duration,
    this.icon,
    this.loaderColor,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.gradient,
    this.image,
    this.imageColor,
    this.imageSize,
    this.imageSpacing,
    this.fontSize,
    this.child,
    this.topLayerWidget,
    this.enableFeedback = true,
    this.useMarqueeTitle = false,
    this.disableButton = false,
    this.loader = false,
    this.borderRadius,
    this.onPressed,
    this.onLongPress,
    this.padding,
    this.margin,
    this.onHighlightChanged,
    this.highlightColor,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool buttonPress = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      tween: widget.loader == true || buttonPress == true ? Tween(begin: 0.9, end: 0.97) : Tween(begin: 1.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: widget.borderRadius ?? commonBorderRadius),
                child: AnimatedContainer(
                  duration: widget.duration ?? defaultDuration,
                  width: widget.flexibleWidth == false ? (widget.width?.w ?? Get.width + (widget.margin?.horizontal ?? 0)) : null,
                  height: widget.flexibleHeight == false ? (widget.height?.w ?? UiUtils.appButtonHight + (widget.margin?.vertical ?? 0)) : null,
                  margin: widget.padding ?? .zero,
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius ?? commonBorderRadius,
                    color: widget.color ?? (widget.buttonType == ButtonType.outline ? null : Theme.of(context).primaryColor.withAppOpacity(withMyOpacity)),
                    border: widget.buttonType == ButtonType.outline ? Border.all(color: widget.borderColor ?? Theme.of(context).primaryColor.withAppOpacity(disableOpacity)) : null,
                    gradient: loadingOrDisableStatus ? (widget.buttonType == ButtonType.gradient ? (widget.gradient ?? LinearGradient(begin: .topLeft, end: .bottomRight, colors: <Color>[Theme.of(context).primaryColor.withAppOpacity(.2), Theme.of(context).primaryColor, Theme.of(context).primaryColor, Theme.of(context).primaryColor.withAppOpacity(.2)])) : null) : null,
                  ),
                  child: RawMaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashColor: Theme.of(context).scaffoldBackgroundColor.withAppOpacity(widget.loader == false ? .1 : 0),
                    highlightColor: widget.highlightColor ?? Theme.of(context).primaryColor.withAppOpacity(widget.buttonType == ButtonType.outline ? .1 : .0),
                    shape: RoundedRectangleBorder(borderRadius: widget.borderRadius ?? commonBorderRadius),
                    hoverElevation: widget.loader == false ? 4.0 : 0.0,
                    elevation: widget.loader == false ? 2.0 : 0.0,
                    disabledElevation: 0,
                    highlightElevation: widget.loader == false ? 8.0 : 0.0,
                    onPressed: loadingOrDisableStatus
                        ? () {
                            if (widget.enableFeedback == true) {
                              HapticFeedback.lightImpact();
                            }
                            widget.onPressed != null ? widget.onPressed!() : null;
                          }
                        : null,
                    onLongPress: loadingOrDisableStatus ? widget.onLongPress : null,
                    onHighlightChanged: loadingOrDisableStatus
                        ? (press) {
                            setState(() {
                              buttonPress = press;
                              widget.onHighlightChanged != null ? widget.onHighlightChanged!(press) : null;
                            });
                          }
                        : null,
                    child: widget.loader == false
                        ? Padding(
                            padding: widget.margin ?? .zero,
                            child: widget.child ?? (widget.flexibleWidth == true ? IntrinsicWidth(child: defaultChild(context)) : defaultChild(context)),
                          )
                        : FittedBox(child: CircularLoader(color: widget.loaderColor ?? (widget.buttonType == ButtonType.outline ? Theme.of(context).primaryColor.withAppOpacity(.7) : Theme.of(context).primaryColor.contrastColor()).withAppOpacity(.9))),
                  ),
                ),
              ),
              if (widget.topLayerWidget != null) IntrinsicHeight(child: widget.topLayerWidget),
            ],
          ),
        );
      },
    );
  }

  Row defaultChild(BuildContext context) {
    return Row(
      mainAxisAlignment: titleMainAxisAlignment(imageAlign: widget.imageAlign),
      children: [
        //** Icon Widget */
        if (!isValEmpty(widget.icon) && isValEmpty(widget.image)) ...[
          Icon(widget.icon, color: Colors.white, size: 24),
          // SizedBox(width: widget.imageSpacing ?? 5),
        ],

        //** Image widget */
        if (widget.imageAlign != null)
          if (widget.imageAlign == ImageAlign.start || widget.imageAlign == ImageAlign.startTitle) imageWidget() else SizedBox(width: widget.imageSpacing ?? 5),

        //** Title Widget */
        if (!isValEmpty(widget.title))
          Flexible(
            child: UiUtils.fadeSwitcherWidget(
              child: MarqueeWidget(
                useMarquee: widget.useMarqueeTitle ?? false,
                child: Text(
                  widget.title!,
                  key: ValueKey<String>(widget.title!),
                  overflow: TextOverflow.ellipsis,
                  style: widget.titleStyle ?? AppTextStyle.appButtonStyle(context).copyWith(color: titleColor, fontSize: widget.fontSize),
                ),
              ),
            ),
          )
        else
          const SizedBox(),

        //** Image widget */
        if (widget.imageAlign != null)
          if (widget.imageAlign == ImageAlign.end || widget.imageAlign == ImageAlign.endTitle) imageWidget() else SizedBox(width: widget.imageSpacing ?? 5),
      ],
    );
  }

  //** Image widget */
  Widget imageWidget() {
    if (!isValEmpty(widget.image)) {
      return Row(
        mainAxisSize: .min,
        crossAxisAlignment: .center,
        children: [
          if (widget.imageAlign == ImageAlign.endTitle && !isValEmpty(widget.title)) SizedBox(width: widget.imageSpacing ?? 5),
          GetUtils.isVector(widget.image!) ? SvgPicture.asset(widget.image!, height: widget.imageSize ?? 22, colorFilter: widget.imageColor != null ? ColorFilter.mode(widget.imageColor!, BlendMode.srcIn) : null, alignment: .bottomLeft) : Image.asset(widget.image!, height: widget.imageSize ?? 22, color: widget.imageColor, alignment: .bottomLeft),
          if (widget.imageAlign == ImageAlign.startTitle && !isValEmpty(widget.title)) SizedBox(width: widget.imageSpacing ?? 5),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  MainAxisAlignment titleMainAxisAlignment({required ImageAlign? imageAlign}) {
    switch (imageAlign) {
      case ImageAlign.start:
        return .spaceBetween;
      case ImageAlign.end:
        return .spaceBetween;
      default:
        return .center;
    }
  }

  Color? get titleColor {
    if (widget.buttonType == ButtonType.outline) {
      return Theme.of(context).primaryColor.withAppOpacity(disableOpacity);
    } else {
      return customColors(context).backgroundLight.withAppOpacity(disableOpacity);
    }
  }

  BorderRadius get commonBorderRadius {
    return BorderRadius.circular(defaultRadius * 10);
  }

  bool get loadingOrDisableStatus {
    return widget.disableButton == false ? (widget.loader == false ? true : false) : false;
  }

  double get withMyOpacity {
    return widget.loader == false ? (widget.disableButton == true ? .2 : 1.0) : .4;
  }

  double get disableOpacity {
    return widget.disableButton == true ? (Get.isDarkMode ? .6 : .9) : 1;
  }
}
