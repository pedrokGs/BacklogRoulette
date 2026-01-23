import 'package:backlog_roulette/core/themes/theme_flavor.dart';
import 'package:flutter/material.dart';

class MintFlavor implements ThemeFlavor {
  @override
  String get name => "Menta Glacial";

  static const _primaryMint = Color(0xFF00C4B4);

  static const _softMintLight = Color(0xFFE0F2F1);


  static const _neonMint = Color(0xFF64FFDA);
  static const _deepForestBg = Color(0xFF121816);
  static const _surfaceForest = Color(0xFF1C2624);

  @override
  ColorScheme get lightColors => ColorScheme.fromSeed(
    seedColor: _primaryMint,
    brightness: Brightness.light,

    primary: _primaryMint,
    onPrimary: Colors.white,

    secondary: const Color(0xFF26C6DA),
    onSecondary: Colors.white,

    surface: Colors.white,
    surfaceContainerHighest: _softMintLight,
    onSurface: const Color(0xFF004D40),
  );

  @override
  ColorScheme get darkColors => const ColorScheme(
    brightness: Brightness.dark,

    primary: _neonMint,
    onPrimary: Color(0xFF00382E),

    primaryContainer: Color(0xFF004D40),
    onPrimaryContainer: _neonMint,

    secondary: Color(0xFF80CBC4),
    onSecondary: Colors.black,

    error: Color(0xFFCF6679),
    onError: Colors.black,

    surface: _surfaceForest,
    onSurface: Color(0xFFE0F2F1),

    surfaceTint: _neonMint,
  );
}