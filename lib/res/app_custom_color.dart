import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  // Primary Colors
  final Color kPrimaryColor;
  final Color secondaryDark;

  // Background Colors
  final Color backgroundLight;
  final Color backgroundDark;
  final Color tabletBackground;

  // Text Colors
  final Color textLoginTitle;
  final Color textPrimaryBlack;
  final Color textSecondaryBlack;
  final Color textGreyDark;
  final Color textGreyMedium;
  final Color textGreyLight;
  final Color textFieldTitle;
  final Color textFieldBorder;
  final Color textError;
  final Color textYellowDark;

  // UI Component Colors
  final Color iconBackground;
  final Color divider;

  // Button & Indicator Colors
  final Color buttonGreen;
  final Color yellowBackground;

  // Miscellaneous Colors
  final Color surfaceGrey;
  final Color whiteColor;
  final Color surfaceColor;

  const CustomColors({
    required this.kPrimaryColor,
    required this.secondaryDark,
    required this.backgroundLight,
    required this.backgroundDark,
    required this.tabletBackground,
    required this.textLoginTitle,
    required this.textPrimaryBlack,
    required this.textSecondaryBlack,
    required this.textGreyDark,
    required this.textGreyMedium,
    required this.textGreyLight,
    required this.textFieldTitle,
    required this.textFieldBorder,
    required this.textError,
    required this.textYellowDark,
    required this.iconBackground,
    required this.divider,
    required this.buttonGreen,
    required this.yellowBackground,
    required this.surfaceGrey,
    required this.whiteColor,
    required this.surfaceColor,
  });

  @override
  CustomColors copyWith({
    Color? primaryRed,
    Color? secondaryDark,
    Color? backgroundLight,
    Color? backgroundDark,
    Color? tabletBackground,
    Color? textLoginTitle,
    Color? textPrimaryBlack,
    Color? textSecondaryBlack,
    Color? textGreyDark,
    Color? textGreyMedium,
    Color? textGreyLight,
    Color? textFieldTitle,
    Color? textFieldBorder,
    Color? textError,
    Color? textYellowDark,
    Color? iconBackground,
    Color? divider,
    Color? buttonGreen,
    Color? yellowBackground,
    Color? surfaceGrey,
    Color? whiteColor,
    Color? surfaceColor,
  }) {
    return CustomColors(
      kPrimaryColor: primaryRed ?? kPrimaryColor,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      backgroundLight: backgroundLight ?? this.backgroundLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      tabletBackground: tabletBackground ?? this.tabletBackground,
      textLoginTitle: textLoginTitle ?? this.textLoginTitle,
      textPrimaryBlack: textPrimaryBlack ?? this.textPrimaryBlack,
      textSecondaryBlack: textSecondaryBlack ?? this.textSecondaryBlack,
      textGreyDark: textGreyDark ?? this.textGreyDark,
      textGreyMedium: textGreyMedium ?? this.textGreyMedium,
      textGreyLight: textGreyLight ?? this.textGreyLight,
      textFieldTitle: textFieldTitle ?? this.textFieldTitle,
      textError: textError ?? this.textError,
      textYellowDark: textYellowDark ?? this.textYellowDark,
      iconBackground: iconBackground ?? this.iconBackground,
      divider: divider ?? this.divider,
      buttonGreen: buttonGreen ?? this.buttonGreen,
      yellowBackground: yellowBackground ?? this.yellowBackground,
      surfaceGrey: surfaceGrey ?? this.surfaceGrey,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
      whiteColor: whiteColor ?? this.whiteColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other == null) return this;
    return CustomColors(
      kPrimaryColor: Color.lerp(kPrimaryColor, other.kPrimaryColor, t)!,
      secondaryDark: Color.lerp(secondaryDark, other.secondaryDark, t)!,
      backgroundLight: Color.lerp(backgroundLight, other.backgroundLight, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      tabletBackground: Color.lerp(tabletBackground, other.tabletBackground, t)!,
      textLoginTitle: Color.lerp(textLoginTitle, other.textLoginTitle, t)!,
      textPrimaryBlack: Color.lerp(textPrimaryBlack, other.textPrimaryBlack, t)!,
      textSecondaryBlack: Color.lerp(textSecondaryBlack, other.textSecondaryBlack, t)!,
      textGreyDark: Color.lerp(textGreyDark, other.textGreyDark, t)!,
      textGreyMedium: Color.lerp(textGreyMedium, other.textGreyMedium, t)!,
      textGreyLight: Color.lerp(textGreyLight, other.textGreyLight, t)!,
      textFieldTitle: Color.lerp(textFieldTitle, other.textFieldTitle, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textYellowDark: Color.lerp(textYellowDark, other.textYellowDark, t)!,
      iconBackground: Color.lerp(iconBackground, other.iconBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      buttonGreen: Color.lerp(buttonGreen, other.buttonGreen, t)!,
      yellowBackground: Color.lerp(yellowBackground, other.yellowBackground, t)!,
      surfaceGrey: Color.lerp(surfaceGrey, other.surfaceGrey, t)!,
      textFieldBorder: Color.lerp(textFieldBorder, other.textFieldBorder, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
    );
  }
}

// ✅ Use this function inside your widgets instead of a global variable
CustomColors customColors(BuildContext context) {
  return Theme.of(context).extension<CustomColors>() ??
      CustomColors(
        kPrimaryColor: Colors.blue,
        // Default values to prevent null errors
        secondaryDark: Colors.black,
        backgroundLight: Colors.white,
        backgroundDark: Colors.black54,
        tabletBackground: Colors.grey.shade200,
        textLoginTitle: Colors.black,
        textPrimaryBlack: Colors.black,
        textSecondaryBlack: Colors.black54,
        textGreyDark: Colors.grey,
        textGreyMedium: Colors.grey.shade600,
        textGreyLight: Colors.grey.shade400,
        textFieldTitle: Colors.grey.shade700,
        textError: Colors.redAccent,
        textYellowDark: Colors.amber.shade700,
        iconBackground: Colors.grey.shade300,
        divider: Colors.grey.shade400,
        buttonGreen: Colors.green,
        yellowBackground: Colors.yellow.shade100,
        surfaceGrey: Colors.grey.shade200,
        textFieldBorder: Colors.grey.shade500,
        whiteColor: Colors.white,
        surfaceColor: Colors.grey.shade800,
      );
}
