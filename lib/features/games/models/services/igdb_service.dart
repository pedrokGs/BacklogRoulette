import 'dart:convert';
import 'package:backlog_roulette/features/games/models/models/game_metadata/game_metadata.dart';
import 'package:http/http.dart' as http;

class IGDBService {
  final String clientId;
  final String clientSecret;
  String? _accessToken;

  IGDBService({required this.clientId, required this.clientSecret});

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
      print('Erro autenticação IGDB: $e');
    }
  }

  String _sanitizeGameName(String name) {
    return name
        .replaceAll(RegExp(r'[™®©]'), '')
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .trim();
  }

  Future<Map<String, GameMetadata>> getGamesMetadataBySteamIds(
    List<String> steamIds,
  ) async {
    print('DEBUG: [IGDB] Iniciando busca em lote para ${steamIds.length} IDs');
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
        print(
          'DEBUG: [IGDB] Erro na API: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print("DEBUG: [IGDB] Erro Batch: $e");
    }
    return {};
  }

  Future<Map<String, dynamic>?> getGameMetadataByName(String gameName) async {
    final cleanName = _sanitizeGameName(gameName);
    print('DEBUG: [IGDB] Buscando via Fallback (Nome): "$gameName"');
    await _authenticate();
    if (_accessToken == null) return null;

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
      print("Erro ao buscar por nome: $e");
    }
    return null;
  }

  String getHighResImageUrl(String? url) {
    if (url == null) return '';
    return 'https:${url.replaceAll('t_thumb', 't_cover_big')}';
  }
}


