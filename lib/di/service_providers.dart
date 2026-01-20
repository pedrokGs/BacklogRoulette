import 'package:backlog_roulette/di/api_providers.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:backlog_roulette/services/game/igdb_service.dart';
import 'package:backlog_roulette/services/game/steam_game_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final steamGameServiceProvider = Provider(
  (ref) => SteamGameService(steamKey: ref.read(steamKeyProvider)),
);
final igdbServiceProvider = Provider(
  (ref) => IGDBService(
    clientId: ref.read(igdbClientIdProvider),
    clientSecret: ref.read(igdbClientSecretProvider),
  ),
);

final gameCoverProvider = FutureProvider.family<String?, Game>((ref, game) async {
  final igdbService = ref.watch(igdbServiceProvider);
  return await igdbService.getCoverForSteamGame(game.steamAppId!, game.name);
});