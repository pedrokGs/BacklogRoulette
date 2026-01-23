import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_screen_state.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteStateNotifier extends Notifier<RouletteScreenState> {
  final Set<String> _selectedIds = {};

  @override
  RouletteScreenState build() {
    return RouletteScreenState.idle();
  }

  Set<String> get selectedIds => _selectedIds;

  void toggleSelection(String gameId) {
    if (_selectedIds.contains(gameId)) {
      _selectedIds.remove(gameId);
    } else {
      _selectedIds.add(gameId);
    }
    ref.notifyListeners();
  }

  void prepareRoulette(List<Game> allGames) {
    final selectedGames = allGames.where((g) => _selectedIds.contains(g.steamAppId)).toList();

    if (selectedGames.isNotEmpty) {
      state = RouletteScreenState.spinning(selectedGames: selectedGames);
    } else {
      state = RouletteScreenState.error(message: "Nenhum jogo selecionado!");
    }
  }
}