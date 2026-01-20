import 'package:backlog_roulette/di/service_providers.dart';
import 'package:backlog_roulette/viewmodels/library/library_screen_state.dart';
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
      final gamesFromSteam = await ref.read(steamGameServiceProvider).getOwnedGamesForSteamId(userId);
      state = LibraryScreenState.loaded(games: gamesFromSteam);
      
      for(var i = 0; i < gamesFromSteam.length; i++){
        final hdCover = await ref.read(igdbServiceProvider).getCoverForSteamGame(gamesFromSteam[i].steamAppId!,gamesFromSteam[i].name);
        if(hdCover!= null){

        }
      }
    } catch(e){
      state = LibraryScreenState.error(message: e.toString());
    }
  }
}