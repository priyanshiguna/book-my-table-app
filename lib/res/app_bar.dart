import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backIconColor;
  final double? elevation;
  final double? toolbarHeight;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final VoidCallback? titleOnTap;
  final Widget? leading;
  final Widget? child;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool centerTitle;
  final bool showBackIcon;
  final EdgeInsets? leadingPadding;
  final PreferredSizeWidget? bottom;
  final double? leadingWidth;
  final double? titleSpacing;
  final Color? color;
  final Color? shadowColor;
  final BorderRadius? borderRadius;

  @override
  final Size preferredSize;

  MyAppBar({super.key, this.title, this.backIconColor, this.titleStyle, this.elevation = 5, this.toolbarHeight, this.bottom, this.onTap, this.actions, this.titleOnTap, this.systemOverlayStyle, this.centerTitle = false, this.showBackIcon = true, this.leading, this.child, this.leadingPadding, this.leadingWidth, this.titleSpacing, this.color, this.borderRadius, this.shadowColor})
    : assert(elevation == null || elevation >= 0.0),
      preferredSize = PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  static double preferredHeightFor(BuildContext context, Size preferredSize) {
    if (preferredSize is PreferredAppBarSize && preferredSize.toolbarHeight == null) {
      return (AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight) + (preferredSize.bottomHeight ?? 0);
    }
    return preferredSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: systemOverlayStyle,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      shadowColor: shadowColor,
      titleSpacing: titleSpacing,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.zero),
      leading: showBackIcon ? UiUtils.backIcon(onPressed: onTap, iconColor: backIconColor) : leading,
      title: GestureDetector(
        onTap: titleOnTap,
        child: child ?? Text(title ?? "", style: titleStyle ?? AppTextStyle.commonAppBarTitleStyle(context)),
      ),
      actions: !isValEmpty(actions)
          ? [
              Padding(
                padding: const .only(right: defaultPadding / 1.7),
                child: Row(children: actions!),
              ),
            ]
          : null,
      bottom: bottom,
    );
  }
}

class PreferredAppBarSize extends Size {
  final double? toolbarHeight;
  final double? bottomHeight;

  PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));
}
