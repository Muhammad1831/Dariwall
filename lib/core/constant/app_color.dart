import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  // Colors
  static const Color primaryColor = Color(0xFF187AB4);
  static const Color secondaryColor = Color(0xFF8D319B);
  static const Color backgroundColor = Color(0xFF0A0F15);
  static const Color surfaceColor = Color(0xFF161B22);
  static const Color cardColor = Color(0xFF1D2430);
  static const Color selectedBorderColor = Color(0xff442E87);
  static const Color divider = Color(0xFF1D2430);

  static const Color onPrimary = Color(0xFFF5F5F5);
  static const Color onTertiary = Color(0xFFF5F5F5);
  static const Color onSurface = Color(0xFFB0BEC5);
  static const Color onSecondary = Color(0xFFB0BEC5);
  static const Color onError = Color(0xFFB0BEC5);

  static const Color successColor = Color(0xFF20E66F);
  static const Color errorColor = Color(0xFFF93827);
  static const Color disabledColor = Color(0xFF595959);
  static const Color warningColor = Color(0xFFFFB74D);
  static const Color infoColor = Color(0xFF64B5F6);

  static const Color textPrimaryColor = Color(0xFFF5F5F5);
  static const Color textSecondary1Color = Color(0xFFB0BEC5);
  static const Color textSecondary2Color = Color(0xFF8C8C8C);

  static const Color priceIncreaseColor = Color(0xFF20E66F);
  static const Color priceDecreaseColor = Color(0xFFF93827);
  static const Color blueColor = Color(0xFF3183FF);

  // Gradients
  static final LinearGradient splashGradient = LinearGradient(
    colors: [
      Color(0xff23272A).withValues(alpha: 0.1),
      Color(0xff4B89A6).withValues(alpha: 0.3),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xff2E3338),
      Color(0xff23272A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient priceDecreaseGradient = LinearGradient(
    colors: [
      Color(0xFFF93827).withAlpha(90),
      Color(0xff0F1419).withAlpha(150),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient priceIncreaseGradient = LinearGradient(
    colors: [
      Color(0xFF20E66F).withAlpha(90),
      Color(0xff0F1419).withAlpha(150),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient logoGradient = LinearGradient(
    colors: [
      Color(0xff3CA0D9),
      Color(0xff6E2C8B),
      Color(0xffD50D8A),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static final LinearGradient logoEnglishGradient = LinearGradient(
    colors: [
      Color(0xff3CA0D9),
      Color(0xff6E2C8B),
      Color(0xffD50D8A),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final LinearGradient glassGradia = LinearGradient(
    colors: [
      Color(0xffffffff).withAlpha(50),
      Color(0xffffffff).withAlpha(125),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shadows
  static final BoxShadow pinkGlowShadow = BoxShadow(
    color: const Color(0xffBF1988),
    blurRadius: 120,
    spreadRadius: 30,
  );

  static final BoxShadow blueGlowShadow = BoxShadow(
    color: const Color(0xff2B9ED9),
    blurRadius: 120,
    spreadRadius: 30,
  );
}
