import 'package:backlog_roulette/di/service_providers.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryStateNotifier extends Notifier<LibraryScreenState>{

  @override
  LibraryScreenState build() {
    return LibraryScreenState.initial();
  }

  void resetState(){
    state = LibraryScreenState.initial();
  }

  Future<void> searchGamesForUserId(String userId) async{
    state = LibraryScreenState.loading();
    try{
      final games = await ref.read(gameRepositoryProvider).getEnrichedGames(userId);
      state = LibraryScreenState.loaded(games: games);
    } catch(e){
      state = LibraryScreenState.error(message: e.toString());
    }
  }
}