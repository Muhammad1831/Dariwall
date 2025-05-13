// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

abstract class AppDimens {
  AppDimens._();

  // Spacing values
  static const double veryVerySmall = 4;
  static const double verySmall = 8;
  static const double small = 12;
  static const double medium = 16;
  static const double large = 24;
  static const double veryLarge = 32;
  static const double extraLarge = 48;

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
  static const double paddingVerySmall = 4;
  static const double paddingSmall = 8;
  static const double paddingMedium = 12;
  static const double paddingLarge = 16;
  static const double paddingVeryLarge = 24;
  static const double paddingExtraLarge = 32;

  static const double marginVerySmall = 4;
  static const double marginSmall = 8;
  static const double marginMedium = 12;
  static const double marginLarge = 16;
  static const double marginVeryLarge = 24;

  // Border Radius
  static const double borderRadiusVerySmall = 4;
  static const double borderRadiusSmall = 8;
  static const double borderRadiusMedium = 12;
  static const double borderRadiusLarge = 16;
  static const double borderRadiusVeryLarge = 24;
  static const double borderRadiusExtraLarge = 50;

  // Icon Sizes
  static const double iconSmall = 16;
  static const double iconMedium = 20;
  static const double iconLarge = 24;
  static const double iconVeryLarge = 32;
  static const double iconExtraLarge = 48;

  // Button Heights
  static const double buttonLargeHeight = 48;
  static const double buttonMediumHeight = 36;
  static const double buttonSmallHeight = 32;
  // Input Heights
  static const double inputLargeHeight = 48;
  static const double inputSmallHeight = 36;

  // card Heights
  static const double cardMediumHeight = 40;
  static const double cardLargeHeight = 64;
}
