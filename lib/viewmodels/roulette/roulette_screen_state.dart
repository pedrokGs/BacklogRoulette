import 'package:backlog_roulette/models/game/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roulette_screen_state.freezed.dart';

@freezed
class RouletteScreenState with _$RouletteScreenState {

  factory RouletteScreenState.idle() = _Idle;

  factory RouletteScreenState.spinning({required List<Game> selectedGames}) = _Spinning;

  factory RouletteScreenState.error({required String message}) = _Error;

  factory RouletteScreenState.loading() = _Loading;
}