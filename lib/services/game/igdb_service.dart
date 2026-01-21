import 'dart:convert';
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
            'https://id.twitch.tv/oauth2/token?client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials'),
      );
      if (response.statusCode == 200) {
        _accessToken = jsonDecode(response.body)['access_token'];
      }
    } catch (e) {
      print('Erro autenticação IGDB: $e');
    }
  }

  /// Busca metadados para uma LISTA de IDs da Steam.
  Future<Map<String, dynamic>> getGamesMetadataBySteamIds(List<String> steamIds) async {
    await _authenticate();
    if (_accessToken == null || steamIds.isEmpty) return {};

    final idsFormatted = steamIds.map((id) => '"$id"').join(',');

    final query = '''
      fields name, cover.url, genres.name, artworks.url, external_games.uid;
      where external_games.category = 1 & external_games.uid = ($idsFormatted);
      limit 500;
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
        final Map<String, dynamic> mappedData = {};

        for (var gameData in data) {
          if (gameData['external_games'] != null) {
            for (var ext in gameData['external_games']) {
              final steamId = ext['uid'].toString();
              mappedData[steamId] = gameData;
            }
          }
        }
        return mappedData;
      }
    } catch (e) {
      print("Erro Batch IGDB: $e");
    }
    return {};
  }

  /// Usar este método no GameRepository quando o ID da Steam não retornar nada.
  Future<Map<String, dynamic>?> getGameMetadataByName(String gameName) async {
    await _authenticate();
    if (_accessToken == null) return null;

    final query = 'fields name, cover.url, genres.name, artworks.url; search "$gameName"; limit 1;';

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
        if (data.isNotEmpty) {
          return data[0];
        }
      }
    } catch (e) {
      print("Erro busca por nome IGDB: $e");
    }
    return null;
  }

  String getHighResImageUrl(String? url) {
    if (url == null) return '';
    return 'https:${url.replaceAll('t_thumb', 't_cover_big')}';
  }
}