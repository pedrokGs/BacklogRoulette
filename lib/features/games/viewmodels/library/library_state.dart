import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_state.freezed.dart';

/// Classe de estado da biblioteca do usuário.
///
/// Possui 4 estados:
///
/// Initial -> Biblioteca vazia, o jogador entrou pela primeira vez
///
/// Loaded -> Carregada com jogos ([state.games])
///
/// Error -> Ocorreu um erro durante o processo ([state.message])
///
/// Loading -> Carregando durante algum processo assíncrono
@freezed
sealed class LibraryState with _$LibraryState {
  factory LibraryState.initial() = _Initial;

  factory LibraryState.loaded({required List<Game> games}) = _Loaded;

  factory LibraryState.error({required String message}) = _Error;

  factory LibraryState.loading() = _Loading;
}
