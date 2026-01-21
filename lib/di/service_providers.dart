import 'package:backlog_roulette/di/api_providers.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:backlog_roulette/repositories/game_repository.dart';
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
final gameRepositoryProvider = Provider((ref) => GameRepository(steamService: ref.watch(steamGameServiceProvider), igdbService: ref.watch(igdbServiceProvider)),);