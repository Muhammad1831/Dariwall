import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ostad/core/constant/app_color.dart';

abstract class AppTextStyle {
  AppTextStyle._();

  static const String iranSansWeb = 'IRANSansWeb';
  static const String timesNewRoman = 'TimesNewRoman';

  // display large
  static TextStyle displayLargeDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // display medium
  static TextStyle displayMediumDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // display small
  static TextStyle displaySmallDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.textPrimaryColor,
  );

  // headline large
  static TextStyle headlineLargeDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary1Color,
  );
  // headline medium
  static TextStyle headlineMediumDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary1Color,
  );
  // headline small
  static TextStyle headlineSmallDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary1Color,
  );

  // label large
  static TextStyle labelLargeDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary2Color,
  );
  // label medium
  static TextStyle labelMediumDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary2Color,
  );
  // label small
  static TextStyle labelSmallDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textSecondary2Color,
  );

  // title small
  static TextStyle titleSmallDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // title medium
  static TextStyle titleMediumDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // title large
  static TextStyle titleLargeDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );

  // body large
  static TextStyle bodyLargeDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // body medium
  static TextStyle bodyMediumDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );
  // body small
  static TextStyle bodySmallDark = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.textPrimaryColor,
  );

  // link style
  static TextStyle linkStyle = TextStyle(
    fontFamily: iranSansWeb,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    color: AppColor.infoColor,
    decorationColor: AppColor.infoColor,
  );
}
