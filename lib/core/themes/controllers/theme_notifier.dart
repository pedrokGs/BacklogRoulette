import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier para gerenciar o modo do tema do aplicativo
///
/// Usado para dar toggle no tema e escutar o tema atual
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  bool get isDark => state == ThemeMode.dark;
  bool get isNotDark => state == ThemeMode.light;

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
