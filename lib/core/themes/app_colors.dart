import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF9146FF);
  static const Color primaryLightPurple = Color(0xFFAF7DFF);
  static const Color primaryDarkPurple = Color(0xFF772CE8);

  static const Color darkBackground = Color(0xFF0E0E10);
  static const Color darkSurface = Color(0xFF18181B);
  static const Color darkOverlay = Color(0xFF1F1F23);
  static const Color darkTextPrimary = Color(0xFFEFEFF1);
  static const Color darkTextSecondary = Color(0xFFADADB8);

  static const Color lightBackground = Color(0xFFF7F7F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOverlay = Color(0xFFEFEFF1);
  static const Color lightTextPrimary = Color(0xFF0E0E10);
  static const Color lightTextSecondary = Color(0xFF53535F);

  static const Color accentSuccess = Color(0xFF00F593);
  static const Color accentError = Color(0xFFFF4665);
  static const Color accentWarning = Color(0xFFFFB31A);

  static const Color borderLight = Color(0xFFDBDBE1);
  static const Color borderDark = Color(0xFF26262C);
  static const Color divider = Color(0x1FADADB8);

  static const Color shadow = Color(0x1A000000);
  static const Color scaffoldSecondary = Color(0xFF1F1F23);

  static const Color hyperLink = Color(0xFF00B5FF);
  static const Color ghostText = Color(0xFF70707A);

  static const Color transparent = Colors.transparent;

  static ColorScheme getColorScheme({required bool isDark}) {
    if (isDark) {
      return const ColorScheme.dark().copyWith(
        primary: primaryPurple,
        primaryContainer: primaryDarkPurple,
        error: accentError,
        onPrimary: darkTextPrimary,
        brightness: Brightness.dark,
        onPrimaryContainer: darkTextPrimary,
        onSurface: darkTextPrimary,
        surface: darkBackground,
        surfaceContainer: darkSurface,
        onErrorContainer: darkOverlay,
        onSecondaryContainer: darkSurface,
      );
    } else {
      return const ColorScheme.light().copyWith(
        primary: primaryPurple,
        primaryContainer: primaryLightPurple,
        error: accentError,
        onPrimary: lightTextPrimary,
        brightness: Brightness.light,
        onPrimaryContainer: lightTextPrimary,
        onSurface: lightTextPrimary,
        surface: lightBackground,
        surfaceContainer: lightSurface,
        onErrorContainer: lightOverlay,
        onSecondaryContainer: lightSurface,
      );
    }
  }
}
