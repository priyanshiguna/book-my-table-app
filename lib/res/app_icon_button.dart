import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/extensions/color_extensions.dart';

class AppIconButton extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressUp;
  final Widget icon;
  final String? tooltip;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? splashColor;
  final Color? shadowColor;
  final bool? disableButton;
  final bool enableFeedback;
  final double? disableButtonOpacity;
  final List<BoxShadow>? boxShadow;

  const AppIconButton({
    super.key,
    this.tooltip,
    this.size = 48,
    required this.onPressed,
    this.onLongPress,
    this.onLongPressUp,
    this.borderRadius,
    required this.icon,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.splashColor,
    this.shadowColor,
    this.disableButton = false,
    this.enableFeedback = true,
    this.disableButtonOpacity,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null ? Border.all(color: borderColor!.withAppOpacity(withMyOpacity), width: borderWidth ?? 1.0) : null,
        boxShadow: boxShadow,
      ),
      child: GestureDetector(
        onLongPress: onLongPress,
        onLongPressUp: onLongPressUp,
        child: IconButton(
          iconSize: size,
          splashRadius: size / 1.5,
          splashColor: splashColor,
          padding: .zero,
          tooltip: tooltip,
          style: IconButton.styleFrom(shadowColor: shadowColor),
          onPressed: disableButton == false
              ? () {
                  if (enableFeedback) {
                    HapticFeedback.lightImpact();
                  }
                  onPressed != null ? onPressed!() : null;
                }
              : null,
          icon: ClipOval(
            child: Material(
              color: backgroundColor?.withAppOpacity(withMyOpacity) ?? Colors.transparent,
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }

  double get withMyOpacity {
    return disableButton == false ? 1 : disableButtonOpacity ?? .4;
  }
}
