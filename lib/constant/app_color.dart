import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  static const Color primaryColor = Color(0xFF4B89A6);
  static const Color secondaryColor = Color(0xFFF0A04B);
  static const Color backgroundColor = Color(0xFF23272A);
  static const Color surfaceColor = Color(0xFF2E3338);
  static const Color cardColor = Color(0xFF2E3236);
  static const Color accentColor = Color(0xFF7BD3EA);

  static const Color successColor = Color(0xFF81C784);
  static const Color errorColor = Color(0xFFE57373);
  static const Color warningColor = Color(0xFFFFB74D);
  static const Color infoColor = Color(0xFF64B5F6);

  static const Color textPrimaryColor = Color(0xFFF5F5F5);
  static const Color textSecondary1Color = Color(0xFFB0BEC5);
  static const Color textSecondary2Color = Color(0xFF8C8C8C);
  static const Color disabledColor = Color(0xFF595959);

  static const Color priceIncreaseColor = Color(0xFF55AD9B);
  static const Color priceDecreaseColor = Color(0xFFFF8A8A);

  static final LinearGradient splashGradient = LinearGradient(
    colors: [
      Color(0xff23272A).withValues(alpha: 0.1),
      Color(0xff4B89A6).withValues(alpha: 0.3),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient priceCardGradient = LinearGradient(
    colors: [
      Color(0xff2E3338),
      Color(0xff23272A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
