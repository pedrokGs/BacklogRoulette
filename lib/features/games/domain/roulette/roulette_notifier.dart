import 'package:backlog_roulette/features/games/data/models/game/game.dart';
import 'package:backlog_roulette/features/games/data/utils/roulette_weight_logic.dart';
import 'package:backlog_roulette/features/games/domain/roulette/roulette_state.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier para roulette
///
/// Gerencia o [RouletteState]
class RouletteNotifier extends Notifier<RouletteState> {
  @override
  RouletteState build() {
    return RouletteState.idle();
  }

  /// Pega os jogos e muda o estado para spinning depois de mapear pesos para os jogos
  void prepareRoulette(List<Game> allGames) {
    state = RouletteState.loading();

    final weights = RouletteWeightLogic.buildWeights(
      allGames: allGames,
      selectedMood: ref.read(moodNotifierProvider),
    );

    if (weights.isNotEmpty) {
      state = RouletteState.spinning(
        selectedGames: weights.keys.toList(),
        weights: weights,
      );
    } else {
      state = RouletteState.error(message: "");
    }
  }
}
