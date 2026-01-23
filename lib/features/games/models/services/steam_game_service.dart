import 'dart:convert';

import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:http/http.dart' as http;

class SteamGameService {
  final String steamKey;

  const SteamGameService({required this.steamKey});

  Future<List<Game>> getUserGames(String steamId) async {
    // Should return a List containing all Games the user has on steam library, ordered by time since last played
    final uri = Uri.parse(
      'https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=$steamKey&steamid=$steamId&format=json&include_appinfo=true&include_played_free_games=true',
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Steam returns: { "response": { "game_count": X, "games": [...] } }
        final List? gamesJson = data['response']['games'];

        if (gamesJson == null) return [];

        final forbiddenTerms = [
          'beta', 'alpha', 'prologue', 'test server',
          'demo', 'trial', 'playtest', 'dedicated server'
        ];

        final gameList = gamesJson
            .map((e) => Game.fromSteam(e))
            .where((game) {
          final nameLower = game.name.toLowerCase();
          return !forbiddenTerms.any((term) => nameLower.contains(term));
        })
            .toList();

        // Order: recently played games first
        gameList.sort((a, b) => b.timeLastPlayed.compareTo(a.timeLastPlayed));

        return gameList;
      } else {
        throw Exception('Erro na API Steam: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao buscar biblioteca: $e');
    }
  }
}
