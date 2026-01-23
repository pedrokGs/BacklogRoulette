import 'package:backlog_roulette/core/themes/theme_controller.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state_notifier.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeController, AppThemeState>(() {
  return ThemeController();
});

final libraryStateNotifier = NotifierProvider(LibraryStateNotifier.new);

final rouletteStateNotifier = NotifierProvider(RouletteStateNotifier.new);