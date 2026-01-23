
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/services/igdb_service.dart';
import 'package:backlog_roulette/features/games/models/services/steam_game_service.dart';

class GameRepository {
  final SteamGameService steamService;
  final IGDBService igdbService;

  GameRepository({
    required this.steamService,
    required this.igdbService,
  });

  Future<List<Game>> getEnrichedGames(String steamUserId) async {
    List<Game> steamGames = [];
    try {
      steamGames = await steamService.getUserGames(steamUserId);
    } catch (e) {
      rethrow;
    }

    if (steamGames.isEmpty) return [];

    final steamIds = steamGames
        .map((g) => g.steamAppId)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    Map<String, dynamic> igdbMetadata = {};
    try {
      igdbMetadata = await igdbService.getGamesMetadataBySteamIds(steamIds);
    } catch (e) {
      print("Aviso: Falha ao buscar dados do IGDB. Usando dados apenas da Steam. Erro: $e");
    }

    final List<Game> enrichedGames = [];

    for (var game in steamGames) {
      var metadata = igdbMetadata[game.steamAppId];

      if (metadata == null) {
        try {
          metadata = await igdbService.getGameMetadataByName(game.name);
        } catch (e) {
          print("Erro no fallback de metadados: $e");
        }
      }

      String finalCoverUrl = game.coverUrl;
      String backupCoverUrl = '';

      if (metadata != null && metadata['cover'] != null) {
        final String? igdbUrl = metadata['cover']['url'];
        if (igdbUrl != null && igdbUrl.isNotEmpty) {
          backupCoverUrl = igdbService.getHighResImageUrl(igdbUrl);
        }
      }

      List<String> finalGenres = [];
      if (metadata != null && metadata['genres'] != null) {
        finalGenres = (metadata['genres'] as List)
            .map((g) => g['name'].toString())
            .toList();
      }

      enrichedGames.add(
        game.copyWith(
          genres: finalGenres,
          coverUrl: finalCoverUrl,
          igdbCoverUrl: backupCoverUrl,
        ),
      );
    }

    enrichedGames.sort((a, b) => b.timeLastPlayed.compareTo(a.timeLastPlayed));

    return enrichedGames;
  }
}