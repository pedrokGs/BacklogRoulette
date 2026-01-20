import 'package:backlog_roulette/themes/theme_flavor.dart';
import 'package:flutter/material.dart';

class OrangeFlavor implements ThemeFlavor {
  @override
  String get name => "Sunset Orange";

  // --- Paleta Solar ---
  static const _sunsetOrange = Color(0xFFFF6B6B);
  static const _deepAmber = Color(0xFFFF9F1C);

  static const _warmBlack = Color(0xFF141110);
  static const _warmSurface = Color(0xFF201A18);

  @override
  ColorScheme get lightColors => ColorScheme.fromSeed(
    seedColor: _sunsetOrange,
    brightness: Brightness.light,

    primary: _sunsetOrange,
    onPrimary: Colors.white,

    secondary: const Color(0xFFFFB74D),

    surface: const Color(0xFFFFF8F3),
    onSurface: const Color(0xFF4E342E),
  );

  @override
  ColorScheme get darkColors => const ColorScheme(
    brightness: Brightness.dark,

    primary: _sunsetOrange,
    onPrimary: Colors.black,

    secondary: _deepAmber,
    onSecondary: Colors.black,

    error: Color(0xFFE57373),
    onError: Colors.white,

    surface: _warmSurface,
    onSurface: Color(0xFFFFEBE5),

    surfaceTint: _sunsetOrange,
  );
}