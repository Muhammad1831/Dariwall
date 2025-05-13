import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  // Colors
  static const Color primaryColor = Color(0xFF34C759);
  static const Color secondaryColor = Color(0xFF9A71D8);
  static const Color backgroundColor = Color(0xFF0C0C1D);
  static const Color surfaceColor = Color(0xFF141429);
  static const Color cardColor = Color(0xFF1A1A2E);
  static const Color selectedBorderColor = Color(0xff442E87);
  static const Color dividerColor = Color(0xFF1A1A2E);
  static Color strokeColor = Color(0xffffffff).withAlpha(25);

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
  static final List<Color> glassBoxColors = [
    Color(0xff181D25).withValues(alpha: 0.6),
    Color(0xff28303E),
  ];

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

  static final LinearGradient strokeGradient = LinearGradient(
    colors: [
      Color(0xff0C0C1D),
      Color(0xffFFFFFF).withValues(alpha: 0.4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient logoGradient = LinearGradient(
    colors: [
      Color(0xff34C759),
      Color(0xff9A71D8),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static final LinearGradient logoEnglishGradient = LinearGradient(
    colors: [
      Color(0xff9A71D8),
      Color(0xff34C759),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final LinearGradient glassGradia = LinearGradient(
    colors: [
      Color(0xffffffff).withValues(alpha: 0.2),
      Color(0xffffffff).withValues(alpha: 0.5),
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
