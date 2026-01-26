import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteNotifier extends Notifier<RouletteState> {
  final Set<String> _selectedIds = {};

  @override
  RouletteState build() {
    return RouletteState.idle();
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
      state = RouletteState.spinning(selectedGames: selectedGames);
    } else {
      state = RouletteState.error(message: "Nenhum jogo selecionado!");
    }
  }
}