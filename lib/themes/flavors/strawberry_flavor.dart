import 'package:backlog_roulette/themes/theme_flavor.dart';
import 'package:flutter/material.dart';

class StrawberryFlavor implements ThemeFlavor {
  @override
  String get name => "Strawberry Sakura";

  static const _sakuraPink = Color(0xFFF48FB1);
  static const _hotPink = Color(0xFFFF4081);

  static const _plumBlack = Color(0xFF1A1118);
  static const _plumSurface = Color(0xFF261822);

  @override
  ColorScheme get lightColors => ColorScheme.fromSeed(
    seedColor: _hotPink,
    brightness: Brightness.light,

    primary: _hotPink,
    onPrimary: Colors.white,

    secondary: const Color(0xFFAD1457),

    surface: const Color(0xFFFFF5F7),
    onSurface: const Color(0xFF4A0E22),
    surfaceContainerHighest: Color(0xFFFCE4EC),
  );

  @override
  ColorScheme get darkColors => const ColorScheme(
    brightness: Brightness.dark,

    primary: _sakuraPink,
    onPrimary: Color(0xFF330018),

    secondary: Color(0xFFEA80FC),
    onSecondary: Colors.black,

    error: Color(0xFFFF80AB),
    onError: Colors.black,

    surface: _plumSurface,
    onSurface: Color(0xFFF8E1E7),

    surfaceTint: _sakuraPink,
  );
}