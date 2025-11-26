import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  ///TODO: CHANGE WHOLE COLOR FILE BASED ON APP THEME

  /// Primary Colors
  static const Color kPrimaryColor = Color(0xFFD1B293);
  static const Color secondary = Color(0x0fffffff);
  static const Color secondaryDark = Color(0xff181214);

  static Color midnightGreen = const Color(0xFF121212);
  static const Color whiteColor = Color(0xFFFFFFFF);

  /// Background Colors
  static const Color backgroundLight = Color(0xff1E1E1E);
  static const Color backgroundDark = Color(0xff1E1E1E);
  static const Color tabletBackground = Color(0xFFF5F5F5);

  /// Text Colors
  static const Color textLoginTitle = Color(0xff1C1C1C);
  static const Color textPrimaryBlack = Color(0xFF808080);
  static const Color textSecondaryBlack = Color(0xFF666666);
  static const Color textGreyDark = Color(0xFF837F80);
  static const Color textGreyMedium = Color(0xFF717171);
  static const Color textGreyLight = Color(0xFF4A4547);
  static const Color textFieldBorder = Color(0xFF999999);
  static const Color textFieldTitle = Color(0xFF777777);
  static const Color textError = Color(0xFFC03744);
  static const Color textYellowDark = Color(0xFF9C6600);
  static const Color surfaceColor = Color(0xFF2C2C2C);

  /// UI Component Colors
  static const Color iconBackground = Color(0xFFF3F3F3);
  static const Color divider = Color(0xFFDDDDDD);

  /// Button & Indicator Colors
  static const Color buttonGreen = Color(0xFF00B716);
  static const Color yellowBackground = Color(0xFFFFF4CB);

  /// Miscellaneous Colors
  static const Color surfaceGrey = Color(0xFFF8F8F8);

  /// Utility Functions
  static Color getColorOnBackground(Color backgroundColor, {bool reverse = false}) {
    if (backgroundColor.computeLuminance() < 0.5) {
      return reverse ? Colors.black : Colors.white;
    } else {
      return reverse ? Colors.white : Colors.black;
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String fromColor(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
