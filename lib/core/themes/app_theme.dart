import 'package:backlog_roulette/core/themes/app_colors.dart';
import 'package:backlog_roulette/core/themes/app_text_themes.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: AppColors.getColorScheme(isDark: false),
    textTheme: AppTextThemes.lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: _outlineInputBorder(AppColors.borderLight),
      focusedBorder: _outlineInputBorder(AppColors.primaryLightPurple),
      errorBorder: _outlineInputBorder(AppColors.accentError),
      focusedErrorBorder: _outlineInputBorder(AppColors.primaryLightPurple),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryPurple,
    )
  );

  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: AppColors.getColorScheme(isDark: true),
    textTheme: AppTextThemes.darkTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: _outlineInputBorder(AppColors.borderDark),
      focusedBorder: _outlineInputBorder(AppColors.primaryDarkPurple),
      errorBorder: _outlineInputBorder(AppColors.accentError),
      focusedErrorBorder: _outlineInputBorder(AppColors.primaryDarkPurple),
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryPurple,
      )
  );
}

OutlineInputBorder _outlineInputBorder(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: BorderSide(color: color, width: 3),
);
