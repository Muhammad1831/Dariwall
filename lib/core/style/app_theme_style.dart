import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/style/app_text_style.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: AppTextStyle.iranSansWeb,

  // Scaffold Background Color
  scaffoldBackgroundColor: AppColor.backgroundColor,
  primaryColor: AppColor.primaryColor,
  disabledColor: AppColor.disabledColor,

  // Color Scheme
  colorScheme: ColorScheme.dark(
    surfaceContainerHighest: AppColor.backgroundColor,
    primary: AppColor.primaryColor,
    surface: AppColor.surfaceColor,
    secondary: AppColor.secondaryColor,
    error: AppColor.errorColor,
    onPrimary: AppColor.onPrimary,
    onSecondary: AppColor.onSecondary,
    onSurface: AppColor.onSurface,
    onError: AppColor.onError,
  ),

  highlightColor: Colors.transparent,

  //popup menu
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
      side: BorderSide(
        color: AppColor.strokeColor,
      ),
    ),
  ),

  // checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.infoColor;
        } else {
          return AppColor.backgroundColor;
        }
      },
    ),
    checkColor: WidgetStatePropertyAll(
      AppColor.backgroundColor,
    ),
    side: BorderSide(
      color: WidgetStateColor.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          } else {
            return AppColor.onPrimary;
          }
        },
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppDimens.borderRadiusVerySmall,
      ),
    ),
  ),

  // switch
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.surfaceColor;
        } else {
          return AppColor.onSurface;
        }
      },
    ),
    trackColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.primaryColor;
        } else {
          return AppColor.cardColor;
        }
      },
    ),
    trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
  ),

  // divider
  dividerTheme: DividerThemeData(
    color: AppColor.dividerColor,
    thickness: 1,
  ),

  // dialog
  dialogTheme: DialogTheme(
    backgroundColor: AppColor.surfaceColor,
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusVerySmall)),
    titleTextStyle: AppTextStyle.titleMediumDark.copyWith(
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: AppTextStyle.bodySmallDark.copyWith(
      color: AppColor.onSurface,
    ),
    barrierColor: AppColor.textSecondary2Color.withAlpha(80),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColor.surfaceColor,
    contentTextStyle: AppTextStyle.titleSmallDark,
  ),

  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColor.cardColor,
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        color: AppColor.textPrimaryColor,
      ),
    ),
    labelTextStyle: WidgetStatePropertyAll(AppTextStyle.bodySmallDark),
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: AppColor.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppDimens.borderRadiusSmall),
        bottomRight: Radius.circular(AppDimens.borderRadiusSmall),
      ),
    ),
  ),

  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColor.primaryColor,
      onPrimary: AppColor.onPrimary,
      secondary: AppColor.backgroundColor,
      onSecondary: AppColor.onPrimary,
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: AppColor.surfaceColor,
    elevation: 0,
  ),

  // Icon Theme
  iconTheme: IconThemeData(
    color: AppColor.onPrimary,
  ),

  primaryIconTheme: IconThemeData(
    color: AppColor.primaryColor,
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
    backgroundColor: AppColor.primaryColor,
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
