import 'dart:convert';

import 'package:http/http.dart' as http;

class IGDBService{
  final String clientId;
  final String clientSecret;
  String? _accessToken;

  IGDBService({required this.clientId, required this.clientSecret});

  Future<void> _authenticate() async {
    if (_accessToken != null) return;

    final response = await http.post(
      Uri.parse('https://id.twitch.tv/oauth2/token?client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials'),
    );

    _accessToken = jsonDecode(response.body)['access_token'];
  }

  // Buscar a capa usando o ID da steam
  Future<String?> getCoverForSteamGame(String steamAppId, String gameName) async {
    await _authenticate();

    // TENTATIVA 1: Pelo ID da Steam
    final String queryById = 'fields cover.url; where external_games.category = 1 & external_games.uid = "$steamAppId";';
    String? url = await _makeIGDBRequest(queryById);

    // TENTATIVA 2: Pelo Nome (Se a primeira falhou)
    if (url == null) {
      // search busca por similaridade, limit 1 pega o resultado mais provável
      final String queryByName = 'fields cover.url; search "$gameName"; limit 1;';
      url = await _makeIGDBRequest(queryByName);
    }

    return url;
  }

// Helper
  Future<String?> _makeIGDBRequest(String query) async {
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
        final List data = jsonDecode(response.body);
        if (data.isNotEmpty && data[0]['cover'] != null) {
          String url = data[0]['cover']['url'];
          return 'https:${url.replaceAll('t_thumb', 't_cover_big')}';
        }
      }
    } catch (e) {
      print("Erro IGDB: $e");
    }
    return null;
  }
}