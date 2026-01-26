import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart';
import 'package:backlog_roulette/features/games/models/utils/roulette_weight_logic.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteNotifier extends Notifier<RouletteState> {
  GameMood _currentMood = GameMood.tranquilo;

  @override
  RouletteState build() {
    return RouletteState.idle();
  }

  GameMood get currentMood => _currentMood;

  void updateMood(GameMood mood) {
    _currentMood = mood;
    ref.notifyListeners();
  }
  void prepareRoulette(List<Game> allGames) {
    state = RouletteState.loading();

    final weights = RouletteWeightLogic.buildWeights(
      allGames: allGames,
      selectedMood: _currentMood,
    );

    if (weights.isNotEmpty) {
      state = RouletteState.spinning(
        selectedGames: weights.keys.toList(),
        weights: weights,
      );
    } else {
      state = RouletteState.error(message: "Sua biblioteca está vazia!");
    }
  }
}