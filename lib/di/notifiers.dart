import 'package:backlog_roulette/features/auth/viewmodels/notifiers/auth_notifier.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state_notifier.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final libraryStateNotifier = NotifierProvider(LibraryStateNotifier.new);

final rouletteStateNotifier = NotifierProvider(RouletteStateNotifier.new);

final authNotifierProvider = NotifierProvider(AuthNotifier.new);