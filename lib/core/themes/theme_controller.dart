import 'package:backlog_roulette/core/themes/flavors/grape_flavor.dart';
import 'package:backlog_roulette/core/themes/theme_flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeState {
  final ThemeFlavor flavor;
  final ThemeMode mode;

  AppThemeState({required this.flavor, required this.mode});

  AppThemeState copyWith({ThemeFlavor? flavor, ThemeMode? mode}) {
    return AppThemeState(
      flavor: flavor ?? this.flavor,
      mode: mode ?? this.mode,
    );
  }
}

class ThemeController extends Notifier<AppThemeState> {
  @override
  AppThemeState build() {
    return AppThemeState(flavor: AcaiFlavor(), mode: ThemeMode.system);
  }

  void changeFlavor(ThemeFlavor newFlavor) {
    state = state.copyWith(flavor: newFlavor);
  }

  void toggleThemeMode() {
    final newMode = state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(mode: newMode);
  }
}