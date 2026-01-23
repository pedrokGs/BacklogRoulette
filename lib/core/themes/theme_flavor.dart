import 'package:flutter/material.dart';

abstract class ThemeFlavor {
  String get name;
  ColorScheme get lightColors;
  ColorScheme get darkColors;
}