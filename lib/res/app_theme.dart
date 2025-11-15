import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../exports.dart';
import 'app_custom_color.dart';

class AppTheme {
  AppTheme._();

  static const String fontFamilyName = 'Poppins';

  /// **Light Theme**
  static ThemeData lightMode(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: customColors(context).kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: customColors(context).backgroundLight,
      shadowColor: const Color(0xFFdedcdc),
      dividerColor: AppColors.divider,
      splashColor: AppColors.kPrimaryColor.withAlpha(200),
      hoverColor: AppColors.kPrimaryColor.withAlpha(100),
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      disabledColor: const Color(0xFFD3D9DD),
      textTheme: buildTextTheme(base: ThemeData.light().textTheme),
      primaryTextTheme: buildTextTheme(base: ThemeData.light().primaryTextTheme),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.kPrimaryColor)),

      /// **Theme Extension for Custom Colors**
      extensions: [
        const CustomColors(
          kPrimaryColor: AppColors.kPrimaryColor,
          secondaryDark: AppColors.secondaryDark,
          backgroundLight: AppColors.backgroundLight,
          backgroundDark: AppColors.backgroundDark,
          tabletBackground: AppColors.tabletBackground,
          textLoginTitle: AppColors.textLoginTitle,
          textPrimaryBlack: AppColors.textPrimaryBlack,
          textSecondaryBlack: AppColors.textSecondaryBlack,
          textGreyDark: AppColors.textGreyDark,
          textGreyMedium: AppColors.textGreyMedium,
          textGreyLight: AppColors.textGreyLight,
          textFieldTitle: AppColors.textFieldTitle,
          textError: AppColors.textError,
          textYellowDark: AppColors.textYellowDark,
          iconBackground: AppColors.iconBackground,
          divider: AppColors.divider,
          buttonGreen: AppColors.buttonGreen,
          yellowBackground: AppColors.yellowBackground,
          surfaceGrey: AppColors.surfaceGrey,
          textFieldBorder: AppColors.textFieldBorder,
        ),
      ],

      /// **Widgets Theme**
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light),
      ),
      popupMenuTheme: const PopupMenuThemeData(elevation: 0, color: Colors.white, surfaceTintColor: Colors.transparent),
      tooltipTheme: TooltipThemeData(
        textStyle: const TextStyle(color: Colors.black),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FCFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.kPrimaryColor, width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.kPrimaryColor, foregroundColor: Colors.white),
      colorScheme: const ColorScheme.light(primary: AppColors.kPrimaryColor, secondary: AppColors.secondaryDark, surface: AppColors.surfaceGrey, error: AppColors.textError),
    );
  }

  /// **Dark Theme**
  static ThemeData darkMode(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      shadowColor: const Color(0x8F000000),
      splashColor: AppColors.kPrimaryColor.withAlpha(200),
      hoverColor: AppColors.kPrimaryColor.withAlpha(100),
      splashFactory: InkRipple.splashFactory,
      canvasColor: AppColors.backgroundDark,
      disabledColor: const Color(0xFFCCCCCC),
      textTheme: buildTextTheme(base: ThemeData.dark().textTheme),
      primaryTextTheme: buildTextTheme(base: ThemeData.dark().primaryTextTheme),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.kPrimaryColor)),

      /// **Theme Extension for Custom Colors**
      extensions: [
        const CustomColors(
          kPrimaryColor: AppColors.kPrimaryColor,
          secondaryDark: AppColors.secondaryDark,
          backgroundLight: AppColors.backgroundDark,
          backgroundDark: AppColors.backgroundLight,
          tabletBackground: AppColors.backgroundDark,
          textLoginTitle: AppColors.textLoginTitle,
          textPrimaryBlack: Colors.white,
          textSecondaryBlack: Colors.white70,
          textGreyDark: AppColors.textGreyDark,
          textGreyMedium: AppColors.textGreyMedium,
          textGreyLight: AppColors.textGreyLight,
          textFieldTitle: AppColors.textFieldTitle,
          textError: AppColors.textError,
          textYellowDark: AppColors.textYellowDark,
          iconBackground: AppColors.iconBackground,
          divider: AppColors.divider,
          buttonGreen: AppColors.buttonGreen,
          yellowBackground: AppColors.yellowBackground,
          surfaceGrey: AppColors.surfaceGrey,
          textFieldBorder: AppColors.textFieldBorder,
          // bannerGradientColors: AppColors.bannerGradientColors,
        ),
      ],

      /// **Widgets Theme**
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xff222222), surfaceTintColor: Colors.transparent),
      tooltipTheme: TooltipThemeData(
        textStyle: const TextStyle(color: Colors.white),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.kPrimaryColor, width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.kPrimaryColor, foregroundColor: Colors.white),
      colorScheme: const ColorScheme.dark(primary: AppColors.kPrimaryColor, secondary: AppColors.secondaryDark, surface: AppColors.surfaceGrey, error: AppColors.textError),
      tabBarTheme: TabBarThemeData(indicatorColor: AppColors.kPrimaryColor),
    );
  }

  /// **Custom Text Theme**
  static TextTheme buildTextTheme({required TextTheme base, String? myFontFamily}) {
    //? If not using responsive font remove both ".sp - 2.5"
    return base.copyWith(
      //* Display
      displayLarge: TextStyle(fontSize: (57.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: base.displayLarge!.color, fontFamily: myFontFamily),
      displayMedium: TextStyle(fontSize: (45.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: base.displayMedium!.color, fontFamily: myFontFamily),
      displaySmall: TextStyle(fontSize: (36.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.displaySmall!.color, fontFamily: myFontFamily),

      //* Headline
      headlineLarge: TextStyle(fontSize: (32.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineLarge!.color, fontFamily: myFontFamily),
      headlineMedium: TextStyle(fontSize: (28.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineMedium!.color, fontFamily: myFontFamily),
      headlineSmall: TextStyle(fontSize: (24.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineSmall!.color, fontFamily: myFontFamily),

      //* Title
      titleLarge: TextStyle(fontSize: (22.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w500, color: base.titleLarge!.color, fontFamily: myFontFamily),
      titleMedium: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.titleMedium!.color, fontFamily: myFontFamily),
      titleSmall: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w500, color: base.titleSmall!.color, fontFamily: myFontFamily),

      //* Label
      labelLarge: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w400, color: base.labelLarge!.color, fontFamily: myFontFamily),
      labelMedium: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.labelMedium!.color, fontFamily: myFontFamily),
      labelSmall: TextStyle(fontSize: (11.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.labelSmall!.color, fontFamily: myFontFamily),

      //* Body Text
      bodyLarge: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.bodyLarge!.color, fontFamily: myFontFamily),
      // This style is flutter default body textStyle (without textStyle)
      bodyMedium: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.bodyMedium!.color, fontFamily: myFontFamily),
      bodySmall: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.4, fontWeight: FontWeight.w400, color: base.bodySmall!.color, fontFamily: myFontFamily),
    );
  }
}
