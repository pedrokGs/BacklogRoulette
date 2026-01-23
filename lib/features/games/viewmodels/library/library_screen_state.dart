import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_screen_state.freezed.dart';

@freezed
class LibraryScreenState with _$LibraryScreenState {
  factory LibraryScreenState.initial() = _Initial;

  factory LibraryScreenState.loaded({required List<Game> games}) = _Loaded;

  factory LibraryScreenState.error({required String message}) = _Error;

  factory LibraryScreenState.loading() = _Loading;

}