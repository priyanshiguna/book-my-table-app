import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_custom_color.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const HeaderWidget({super.key, required this.title, this.color, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: customColors(context).whiteColor,
        fontSize: 18.sp,
      ),
    );
  }
}
