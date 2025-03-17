import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

abstract class AppDimens {
  AppDimens._();

  // Spacing values
  static double get veryVerySmall => 4.r;
  static double get verySmall => 8.r;
  static double get small => 12.r;
  static double get medium => 16.r;
  static double get large => 24.r;
  static double get veryLarge => 32.r;
  static double get extraLarge => 48.r;

  // SizedBox for vertical spacing
  static SizedBox get vSpaceVeryVerySmall => SizedBox(height: veryVerySmall);
  static SizedBox get vSpaceVerySmall => SizedBox(height: veryVerySmall);
  static SizedBox get vSpaceSmall => SizedBox(height: small);
  static SizedBox get vSpaceMedium => SizedBox(height: medium);
  static SizedBox get vSpaceLarge => SizedBox(height: large);
  static SizedBox get vSpaceVeryLarge => SizedBox(height: veryLarge);
  static SizedBox get vSpaceExtraLarge => SizedBox(height: extraLarge);

  // SizedBox for horizontal spacing
  static SizedBox get hSpaceVeryVerySmall => SizedBox(width: veryVerySmall);
  static SizedBox get hSpaceVerySmall => SizedBox(width: verySmall);
  static SizedBox get hSpaceSmall => SizedBox(width: small);
  static SizedBox get hSpaceMedium => SizedBox(width: medium);
  static SizedBox get hSpaceLarge => SizedBox(width: large);
  static SizedBox get hSpaceVeryLarge => SizedBox(width: veryLarge);
  static SizedBox get hSpaceExtraLarge => SizedBox(width: extraLarge);

  // Padding and Margin
  static double get paddingVerySmall => 4.w;
  static double get paddingSmall => 8.w;
  static double get paddingMedium => 12.w;
  static double get paddingLarge => 16.w;
  static double get paddingVeryLarge => 24.w;

  static double get marginVerySmall => 4.w;
  static double get marginSmall => 8.w;
  static double get marginMedium => 12.w;
  static double get marginLarge => 16.w;
  static double get marginVeryLarge => 24.w;

  // Border Radius
  static double get borderRadiusSmall => 8.r;
  static double get borderRadiusMedium => 12.r;
  static double get borderRadiusLarge => 16.r;
  static double get borderRadiusExtraLarge => 50.r;

  // Icon Sizes
  static double get iconSmall => 16.r;
  static double get iconMedium => 24.r;
  static double get iconLarge => 32.r;

  // Button Heights
  static double get buttonHeight => 48.h;
  static double get buttonSmallHeight => 36.h;

  // Input Heights
  static double get inputHeight => 48.h;
  static double get inputSmallHeight => 36.h;
}
