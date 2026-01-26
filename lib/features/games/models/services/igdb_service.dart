import 'dart:convert';
import 'dart:developer';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/models/game_metadata/game_metadata.dart';
import 'package:backlog_roulette/features/games/models/repositories/game_repository.dart';
import 'package:http/http.dart' as http;

/// IGDB SERVICE
/// Responsável por efetuar chamadas de API para IGDB
/// Essa classes só deve ser chamada quando necessário, a fim de poupar chamadas e tempo
/// Sempre preferir dados cacheados do que vindo da API
class IGDBService {
  final String clientId;
  final String clientSecret;
  String? _accessToken;

  IGDBService({required this.clientId, required this.clientSecret});

  /// Autentica com secret e id para tornar possível as chamadas de api
  Future<void> _authenticate() async {
    if (_accessToken != null) return;
    try {
      final response = await http.post(
        Uri.parse(
          'https://id.twitch.tv/oauth2/token?client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials',
        ),
      );
      if (response.statusCode == 200) {
        _accessToken = jsonDecode(response.body)['access_token'];
      }
    } catch (e) {
      log('Erro autenticação IGDB: $e');
    }
  }

  /// Retorna uma coleção contendo metadados dos jogos do usuário com base nos Ids da steam
  ///
  /// Esse método é utilizado internamente no [GameRepository] para mesclar
  /// informações entre [Game] e [GameMetadata]
  Future<Map<String, GameMetadata>> getGamesMetadataBySteamIds(
    List<String> steamIds,
  ) async {
    log('DEBUG: [IGDB] Iniciando busca em lote para ${steamIds.length} IDs');
    await _authenticate();
    if (_accessToken == null || steamIds.isEmpty) return {};

    final idsFormatted = steamIds.map((id) => '"$id"').join(',');

    final query =
        '''
          fields 
            uid, 
            game.name, 
            game.cover.url, 
            game.genres.name, 
            game.artworks.url;
          where uid = ($idsFormatted) & external_game_source = 1;
          limit 500;
        ''';
    try {
      final response = await http.post(
        Uri.parse('https://api.igdb.com/v4/external_games'),
        headers: {
          'Client-ID': clientId,
          'Authorization': 'Bearer $_accessToken',
        },
        body: query,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final Map<String, GameMetadata> mappedData = {};

        for (var entry in data) {
          final steamId = entry['uid'].toString();
          final gameJson = entry['game'];

          if (gameJson != null) {
            mappedData[steamId] = GameMetadata.fromJson(
              gameJson as Map<String, dynamic>,
              steamId: steamId,
            );
          }
        }
        return mappedData;
      } else {
        log(
          'DEBUG: [IGDB] Erro na API: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      log("DEBUG: [IGDB] Erro Batch: $e");
    }
    return {};
  }

  /// Remove todos os caracteres especiais para tornar a busca por nome mais precisa
  String _sanitizeGameName(String name) {
    return name
        .replaceAll(RegExp(r'[™®©]'), '')
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .trim();
  }

  /// Função fallback, uso apenas quando estritamente necessário
  ///
  /// **Atenção:** O Método executa uma busca no IGDB de um único jogo utilizando o nome diretamente, isso acaba gerando
  /// um alto custo, tanto em tempo quanto em chamadas, logo, esse método só é utilizado quando o método
  /// de busca em lote por IDs não funciona
  /// Retorna um [Map] com os dados crus ou `null` se não encontrar.
  Future<Map<String, dynamic>?> getGameMetadataByName(String gameName) async {
    final cleanName = _sanitizeGameName(gameName);
    log('DEBUG: [IGDB] Buscando via Fallback (Nome): "$gameName"');
    await _authenticate();
    if (_accessToken == null) return null;

    // O delay de 250ms é necessário para não estourar o Rate Limit da IGDB (4 requests/segundo)
    await Future.delayed(Duration(milliseconds: 250));

    final query =
        '''
    search "$cleanName";
    fields 
      id, 
      name, 
      cover.url, 
      genres.name;
    limit 1;
  ''';

    try {
      final response = await http.post(
        Uri.parse('https://api.igdb.com/v4/games'),
        headers: {
          'Client-ID': clientId,
          'Authorization': 'Bearer $_accessToken',
        },
        body: query,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.isNotEmpty ? data.first : null;
      }
    } catch (e) {
      log("Erro ao buscar por nome: $e");
    }
    return null;
  }

  /// Função helper para pegar imagem de melhor qualidade
  String getHighResImageUrl(String? url) {
    if (url == null) return '';
    return 'https:${url.replaceAll('t_thumb', 't_cover_big')}';
  }
}


