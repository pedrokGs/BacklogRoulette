import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/models/game_metadata/game_metadata.dart';
import 'package:backlog_roulette/features/games/models/services/igdb_service.dart';
import 'package:backlog_roulette/features/games/models/services/steam_game_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameRepository {
  final SteamGameService steamService;
  final IGDBService igdbService;
  final FirebaseFirestore firestore;

  GameRepository({
    required this.steamService,
    required this.igdbService,
    required this.firestore
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

    final Map<String, GameMetadata> cachedMetadata = await _getMetadataFromCache(steamIds);
    final missingIds = steamIds.where((id) => !cachedMetadata.containsKey(id)).toList();

    Map<String, GameMetadata> newIgdbMetadata = {};
    if (missingIds.isNotEmpty) {
      try {
        newIgdbMetadata = await igdbService.getGamesMetadataBySteamIds(missingIds);

        if (newIgdbMetadata.isNotEmpty) {
          _saveMetadataToCache(newIgdbMetadata);
        }
      } catch (e) {
        print("Erro IGDB: $e");
      }
    }
    final allMetadata = {...cachedMetadata, ...newIgdbMetadata};

    final Map<String, GameMetadata> fallbackMetadataToSave = {};
    final List<Game> enrichedGames = [];

    for (var game in steamGames) {
      GameMetadata? metadata = allMetadata[game.steamAppId];

      if (metadata == null && game.steamAppId != null) {
        try {
          final raw = await igdbService.getGameMetadataByName(game.name);
          if (raw != null) {
            metadata = GameMetadata.fromJson(raw, steamId: game.steamAppId);
            fallbackMetadataToSave[game.steamAppId!] = metadata;
          }
        } catch (e) {
          print("Erro fallback nome para ${game.name}: $e");
        }
      }

      enrichedGames.add(
        game.copyWith(
          genres: metadata?.genres ?? [],
          igdbCoverUrl: metadata?.coverUrl != null
              ? igdbService.getHighResImageUrl(metadata!.coverUrl!)
              : '',
        ),
      );
    }

    if (fallbackMetadataToSave.isNotEmpty) {
      print("DEBUG: Salvando ${fallbackMetadataToSave.length} itens encontrados via fallback de nome");
      _saveMetadataToCache(fallbackMetadataToSave);
    }

    return enrichedGames..sort((a, b) => b.timeLastPlayed.compareTo(a.timeLastPlayed));
  }

  void _saveMetadataToCache(Map<String, GameMetadata> metadataMap) {
    final batch = firestore.batch();

    metadataMap.forEach((steamId, metadata) {
      final docRef = firestore.collection('game_metadata').doc(steamId);

      final dataToSave = {
        ...metadata.toJson(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      batch.set(docRef, dataToSave, SetOptions(merge: true));
    });

    batch.commit().catchError((e) => print("Erro ao salvar cache: $e"));
  }

  Future<Map<String, GameMetadata>> _getMetadataFromCache(List<String> steamIds) async {
    final Map<String, GameMetadata> cachedMetadata = {};
    if (steamIds.isEmpty) return {};

    const int chunkSize = 30;
    for (var i = 0; i < steamIds.length; i += chunkSize) {
      final chunk = steamIds.sublist(i, i + chunkSize > steamIds.length ? steamIds.length : i + chunkSize);

      final snapshot = await firestore
          .collection('game_metadata')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      for (var doc in snapshot.docs) {
        cachedMetadata[doc.id] = GameMetadata.fromJson(doc.data());
      }
    }
    return cachedMetadata;
  }
}