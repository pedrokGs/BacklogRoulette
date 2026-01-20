import 'package:backlog_roulette/themes/theme_controller.dart';
import 'package:backlog_roulette/viewmodels/library/library_state_notifier.dart';
import 'package:backlog_roulette/viewmodels/roulette/roulette_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeController, AppThemeState>(() {
  return ThemeController();
});

final libraryStateNotifier = NotifierProvider(LibraryStateNotifier.new);

final rouletteStateNotifier = NotifierProvider(RouletteStateNotifier.new);