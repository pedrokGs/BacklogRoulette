import 'package:backlog_roulette/themes/theme_flavor.dart';
import 'package:flutter/material.dart';

class AcaiFlavor implements ThemeFlavor {
  @override
  String get name => "Açaí Stream";

  static const _twitchPurple = Color(0xFF9146FF);
  static const _twitchPurpleLight = Color(0xFFBF94FF);

  static const _deepBackground = Color(0xFF0E0E10);
  static const _surfaceGrey = Color(0xFF18181B);

  static const _accentCyan = Color(0xFF00F5FF);

  @override
  ColorScheme get lightColors => ColorScheme.fromSeed(
    seedColor: _twitchPurple,
    brightness: Brightness.light,
    primary: _twitchPurple,
    surface: const Color(0xFFF7F7F8),
    onSurface: const Color(0xFF0E0E10),
    secondary: const Color(0xFF2C2C35),
  );

  @override
  ColorScheme get darkColors => const ColorScheme(
    brightness: Brightness.dark,

    primary: _twitchPurple,
    onPrimary: Colors.white,
    primaryContainer: _twitchPurpleLight,
    onPrimaryContainer: _deepBackground,

    secondary: _accentCyan,
    onSecondary: Colors.black,

    error: Color(0xFFFF4F4D),
    onError: Colors.white,

    surface: _surfaceGrey,
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF26262C),

    surfaceTint: _twitchPurple,
  );
}

