import 'dart:developer';

import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/models/game_metadata/game_metadata.dart';
import 'package:backlog_roulette/features/games/models/services/igdb_service.dart';
import 'package:backlog_roulette/features/games/models/services/steam_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Classe responsável por atuar como a fonte de verdade para jogos
///
/// O [GameRepository] é responsável por grande parte do backend, suas principais funções são: Unir [Game] e [GameMetadata]
/// a fim de adquirir um [Game] completo, buscar jogos já cadastrados no cache (Firestore) e salvar novos jogos não cadastrados
/// no cache
class GameRepository {
  final SteamService steamService;
  final IGDBService igdbService;
  final FirebaseFirestore firestore;

  GameRepository({
    required this.steamService,
    required this.igdbService,
    required this.firestore,
  });

  /// Pega jogos da steam do player e enriquece eles com as informações do IGDB
  ///
  /// Essa função faz uma ponte entre o [SteamService] e o [IGDBService] a fim de garantir que os jogos instanciados no sistema
  /// tenham informações completas. O método recebe uma [String] steamUserId e retorna uma [List]<[Game]> com os jogos já
  /// enriquecidos,
  /// Também é responsável por verificar se o jogo já existe no cache (firestore), e carregar de lá a fim de evitar chamadas
  /// desnecessárias ao [IGDBService], caso o jogo não exista no cache, ela salva ele no mesmo, garantindo que todos os próximos
  /// usuários que tenham aquele jogo tenham um acesso mais rápido.
  Future<List<Game>> getEnrichedGames(
    String steamUserId, {
    bool shouldIncludeFree = false,
  }) async {
    List<Game> steamGames = [];
    try {
      steamGames = await steamService.getUserGames(
        steamUserId,
        shouldIncludeFree: shouldIncludeFree,
      );
    } catch (e) {
      rethrow;
    }

    if (steamGames.isEmpty) return [];

    // Alguns jogos vinham sem ID, fazemos essa verificação para impedir isso
    final steamIds = steamGames
        .map((g) => g.steamAppId)
        .where((id) => id != null && id.isNotEmpty)
        .cast<String>()
        .toList();

    final Map<String, GameMetadata> cachedMetadata =
        await _getMetadataFromCache(steamIds);

    // Separa os IDs que vão ser buscados no IGDB
    final missingIds = steamIds
        .where((id) => !cachedMetadata.containsKey(id))
        .toList();

    Map<String, GameMetadata> newIgdbMetadata = {};
    if (missingIds.isNotEmpty) {
      try {
        newIgdbMetadata = await igdbService.getGamesMetadataBySteamIds(
          missingIds,
        );

        if (newIgdbMetadata.isNotEmpty) {
          _saveMetadataToCache(newIgdbMetadata);
        }
      } catch (e) {
        log("Erro IGDB: $e");
      }
    }

    // Mescla os dados do Cache com os dados novos do IGDB caso tenham
    final allMetadata = {...cachedMetadata, ...newIgdbMetadata};

    final Map<String, GameMetadata> fallbackMetadataToSave = {};
    final List<Game> enrichedGames = [];

    for (var game in steamGames) {
      GameMetadata? metadata = allMetadata[game.steamAppId];

      if (metadata == null && game.steamAppId != null) {
        try {
          // Fallback para tentar buscar por nome, espera-se que não seja necessário, pode causar problemas de atraso
          // e chamadas excessivas para a api
          final raw = await igdbService.getGameMetadataByName(game.name);
          if (raw != null) {
            metadata = GameMetadata.fromJson(raw, steamId: game.steamAppId);
            fallbackMetadataToSave[game.steamAppId!] = metadata;
          }
        } catch (e) {
          log("Erro fallback nome para ${game.name}: $e");
        }
      }

      enrichedGames.add(
        game.copyWith(
          summary: metadata?.summary ?? "",
          genres: metadata?.genres ?? [],
          igdbCoverUrl: metadata?.coverUrl != null
              ? igdbService.getHighResImageUrl(metadata!.coverUrl!)
              : '',
        ),
      );
    }

    if (fallbackMetadataToSave.isNotEmpty) {
      log(
        "DEBUG: Salvando ${fallbackMetadataToSave.length} itens encontrados via fallback de nome",
      );
      _saveMetadataToCache(fallbackMetadataToSave);
    }

    return enrichedGames
      ..sort((a, b) => b.timeLastPlayed.compareTo(a.timeLastPlayed));
  }

  /// Salva as informações de novos jogos no cache (firestore)
  ///
  /// Utilizada quando não encontramos o jogo cadastrado no cache. Buscamos os metadados do jogo faltante e salvamos
  /// ele no cache para persistência e para que os outros usuários possam ter uma experiência mais sutil na aplicação
  /// Salva em lotes (batch) para evitar chamadas desnecessárias ao firestore
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

    batch.commit().catchError((e) => log("Erro ao salvar cache: $e"));
  }

  /// Pega as informações de jogos no cache (firestore)
  ///
  /// Utilizada antes de buscar qualquer informação no IGDB, responsável por garantir que o usuário não tenha um
  /// tempo de espera muito grande ou possa ocorrer problemas com a API.
  Future<Map<String, GameMetadata>> _getMetadataFromCache(
    List<String> steamIds,
  ) async {
    final Map<String, GameMetadata> cachedMetadata = {};
    if (steamIds.isEmpty) return {};

    const int chunkSize = 30;
    for (var i = 0; i < steamIds.length; i += chunkSize) {
      final chunk = steamIds.sublist(
        i,
        i + chunkSize > steamIds.length ? steamIds.length : i + chunkSize,
      );

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
