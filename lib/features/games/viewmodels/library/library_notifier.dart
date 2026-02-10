import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryNotifier extends Notifier<LibraryState> {
  @override
  LibraryState build() {
    return LibraryState.initial();
  }

  void resetState() {
    state = LibraryState.initial();
  }

  Future<void> searchGamesForUserId(String userId) async {
    state = LibraryState.loading();
    try {
      final games = await ref
          .read(gameRepositoryProvider)
          .getEnrichedGames(userId);
      state = LibraryState.loaded(games: games);
    } catch (e) {
      state = LibraryState.error(message: e.toString());
    }
  }
}
