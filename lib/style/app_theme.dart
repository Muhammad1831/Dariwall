import 'package:flutter/material.dart';
import 'package:ostad/constant/app_color.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/style/app_text_style.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  // Scaffold Background Color
  scaffoldBackgroundColor: AppColor.backgroundColor,

  // Color Scheme
  colorScheme: ColorScheme.dark(
    surfaceContainerHighest: AppColor.backgroundColor,
    surface: AppColor.surfaceColor,
    primary: AppColor.primaryColor,
    secondary: AppColor.secondaryColor,
    tertiary: AppColor.accentColor,
    error: AppColor.errorColor,

    onPrimary: AppColor.textPrimaryColor,
    onSecondary: AppColor.textSecondary1Color,
    outline: AppColor.textSecondary2Color,
    outlineVariant: AppColor.disabledColor,
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: AppColor.cardColor,
    elevation: 0,
  ),

  // Icon Theme
  iconTheme: IconThemeData(
    color: AppColor.textSecondary1Color,
  ),

  primaryIconTheme: IconThemeData(
    color: AppColor.textPrimaryColor,
  ),

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.backgroundColor,
    foregroundColor: AppColor.textPrimaryColor,
    elevation: 0,
  ),

  // Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.textPrimaryColor,
      disabledBackgroundColor: AppColor.disabledColor,
    ),
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.accentColor,
    foregroundColor: AppColor.backgroundColor,
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.surfaceColor,
    hintStyle: AppTextStyle.labelMediumDark,
    labelStyle: AppTextStyle.labelMediumDark,
    errorStyle: AppTextStyle.labelSmallDark.copyWith(color: AppColor.errorColor),
    suffixIconColor: AppColor.textSecondary2Color,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.surfaceColor),
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.surfaceColor),
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.surfaceColor),
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor),
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.errorColor),
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
    ),
  ),

  // Text Theme
  textTheme: TextTheme(
    displayLarge: AppTextStyle.displayLargeDark,
    displayMedium: AppTextStyle.displayMediumDark,
    displaySmall: AppTextStyle.displaySmallDark,
    headlineLarge: AppTextStyle.headlineLargeDark,
    headlineMedium: AppTextStyle.headlineMediumDark,
    headlineSmall: AppTextStyle.headlineSmallDark,
    titleLarge: AppTextStyle.titleLargeDark,
    titleMedium: AppTextStyle.titleMediumDark,
    titleSmall: AppTextStyle.titleSmallDark,
    bodyLarge: AppTextStyle.bodyLargeDark,
    bodyMedium: AppTextStyle.bodyMediumDark,
    bodySmall: AppTextStyle.bodySmallDark,
    labelLarge: AppTextStyle.labelLargeDark,
    labelMedium: AppTextStyle.labelMediumDark,
    labelSmall: AppTextStyle.labelSmallDark,
  ),
);
