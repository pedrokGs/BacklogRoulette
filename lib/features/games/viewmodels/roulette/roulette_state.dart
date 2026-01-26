import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roulette_state.freezed.dart';

/// Classe de estado da roleta atual.
///
/// Possui 4 estados:
///
/// Idle -> A roleta está parada, pode ser rodada
///
/// Spinning -> A roleta está rodando, ações são bloqueadas durante esse processo
///
/// Error -> Ocorreu um erro durante o processo ([state.message])
///
/// Loading -> Carregando durante algum processo assíncrono
@freezed
class RouletteState with _$RouletteState {
  factory RouletteState.idle() = _Idle;

  factory RouletteState.spinning({
    required List<Game> selectedGames,
    required Map<Game, double> weights,
  }) = _Spinning;

  factory RouletteState.error({required String message}) = _Error;

  factory RouletteState.loading() = _Loading;
}
