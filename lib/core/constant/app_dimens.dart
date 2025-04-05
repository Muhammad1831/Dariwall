// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

abstract class AppDimens {
  AppDimens._();

  // Spacing values
  static double get veryVerySmall => 4;
  static double get verySmall => 8;
  static double get small => 12;
  static double get medium => 16;
  static double get large => 24;
  static double get veryLarge => 32;
  static double get extraLarge => 48;

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
  static double get paddingVerySmall => 4;
  static double get paddingSmall => 8;
  static double get paddingMedium => 12;
  static double get paddingLarge => 16;
  static double get paddingVeryLarge => 24;

  static double get marginVerySmall => 4;
  static double get marginSmall => 8;
  static double get marginMedium => 12;
  static double get marginLarge => 16;
  static double get marginVeryLarge => 24;

  // Border Radius
  static double get borderRadiusVerySmall => 4;
  static double get borderRadiusSmall => 8;
  static double get borderRadiusMedium => 12;
  static double get borderRadiusLarge => 16;
  static double get borderRadiusExtraLarge => 50;

  // Icon Sizes
  static double get iconSmall => 16;
  static double get iconMedium => 20;
  static double get iconLarge => 24;
  static double get iconVeryLarge => 32;
  static double get iconExtraLarge => 48;

  // Button Heights
  static double get buttonLargeHeight => 48;
  static double get buttonMediumHeight => 36;
  static double get buttonSmallHeight => 32;
  // Input Heights
  static double get inputLargeHeight => 48;
  static double get inputSmallHeight => 36;

  // card Heights
  static double get cardMediumHeight => 40;
  static double get cardLargeHeight => 64;
}
