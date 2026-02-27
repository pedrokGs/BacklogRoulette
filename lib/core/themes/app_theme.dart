import 'package:backlog_roulette/core/themes/app_palette.dart';
import 'package:backlog_roulette/core/themes/app_typography.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: AppPalette.getColorScheme(isDark: false),
    textTheme: AppTypography.lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: _outlineInputBorder(AppPalette.borderLight),
      focusedBorder: _outlineInputBorder(AppPalette.primaryLightPurple),
      errorBorder: _outlineInputBorder(AppPalette.accentError),
      focusedErrorBorder: _outlineInputBorder(AppPalette.primaryLightPurple),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppPalette.primaryPurple,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: AppPalette.getColorScheme(isDark: true),
    textTheme: AppTypography.darkTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: _outlineInputBorder(AppPalette.borderDark),
      focusedBorder: _outlineInputBorder(AppPalette.primaryDarkPurple),
      errorBorder: _outlineInputBorder(AppPalette.accentError),
      focusedErrorBorder: _outlineInputBorder(AppPalette.primaryDarkPurple),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppPalette.primaryPurple,
    ),
  );
}

OutlineInputBorder _outlineInputBorder(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: BorderSide(color: color, width: 3),
);
