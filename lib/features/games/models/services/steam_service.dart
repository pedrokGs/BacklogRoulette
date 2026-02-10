import 'dart:convert';

import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/models/game_metadata/game_metadata.dart';
import 'package:backlog_roulette/features/games/models/repositories/game_repository.dart';
import 'package:http/http.dart' as http;

/// Essa classe é responsável por efetuar chamadas à API da steam
///
/// O principal uso dessa classe é buscar informações relevantes ao usuário, tais como biblioteca, tempo de jogo, etc
/// Essa classe não se responsabiliza por entregar informações absolutas de jogos, pelo contrário, ela retorna apenas
/// informações referentes ao usuário, e nenhuma verdade absoluta sobre o jogo, isso é papel da mesclagem com os dados
/// da IGDB por meio do [GameRepository].
class SteamService {
  final String steamKey;

  const SteamService({required this.steamKey});

  /// Retorna uma lista contendo Jogos [Game] do usuário por meio de seu ID Steam.
  ///
  /// O Retorno é dado por uma [List] de [Game] ordenado por tempo de jogo desde a última sessão (last_played)
  /// A informação retornada sobre o jogo em si não é verídica, pois não contem metadados relevantes. Isso é papel da
  /// [GameMetadata]
  Future<List<Game>> getUserGames(
    String steamId, {
    bool shouldIncludeFree = false,
  }) async {
    final uri = Uri.parse(
      'https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=$steamKey&steamid=$steamId&format=json&include_appinfo=true&include_played_free_games=$shouldIncludeFree',
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List? gamesJson = data['response']['games'];

        if (gamesJson == null) return [];

        // Retorno proibido para os seguintes termos
        // Isso é necessário pois esse jogos podem não possuir ID cadastrado na IGDB, por serem betas, alphas, etc
        final forbiddenTerms = [
          'beta',
          'alpha',
          'prologue',
          'test server',
          'demo',
          'trial',
          'playtest',
          'dedicated server',
        ];

        final gameList = gamesJson.map((e) => Game.fromSteam(e)).where((game) {
          final nameLower = game.name.toLowerCase();
          return !forbiddenTerms.any((term) => nameLower.contains(term));
        }).toList();

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
