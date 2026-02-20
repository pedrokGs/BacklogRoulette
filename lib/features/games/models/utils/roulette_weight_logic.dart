import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/viewmodels/helpers/emotion_to_genre.dart';

class RouletteWeightLogic {
  static Map<Game, double> buildWeights({
    required List<Game> allGames,
    GameMood? selectedMood,
    double? maxTimeHours,
  }) {
    Map<Game, double> weights = {};

    for (var game in allGames) {
      double score = 1.0; // Peso base

      // Lógica de Mood Refinada (Match Density)
      if (selectedMood != null) {
        final allowedGenres = moodToGenres[selectedMood] ?? {};
        final gameGenres = game.genres.toSet();
        final matches = gameGenres.intersection(allowedGenres).length;

        if (matches > 0) {
          // Ex: Se bater 3 tags (Casual, Relaxing, Farming), ganha 30 pontos.
          // Se bater só 1 tag (ex: "Short" num jogo de terror), ganha só 10.
          // Isso faz Stardew Valley ganhar de Doom na categoria Tranquilo.
          score += 20.0;
          if (matches >= 1) score += 15.0;
          if (matches >= 2) score += 10.0;
          if (matches > 2) {
            score += (matches - 2) * 2.0;
          }
        } else {
          // Opcional: Um bônus extra só por ter entrado no mood
          score *= 0.3;
        }
      }

      // Lógica de Tempo ainda não feita
      if (maxTimeHours != null && game.playtime > 0) {
        double gameHours = game.playtime / 60; // Assumindo playtime em minutos

        if (gameHours <= maxTimeHours) {
          score += 10.0;

          // Sugestão: Se o jogo for MUITO curto e o tempo for curto, dar mais pontos?
          // score += (maxTimeHours - gameHours); // Prioriza os que cabem com folga
        } else {
          // Se o jogo é maior que o tempo disponível, reduzimos o peso drasticamente?
          // score = 0.1; // Ou removemos da lista?
        }
      }

      weights[game] = score;
    }
    return weights;
  }
}
