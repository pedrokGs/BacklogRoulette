import 'package:backlog_roulette/features/games/domain/enums/game_mood_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodNotifier extends Notifier<GameMood> {
  @override
  GameMood build() {
    return GameMood.calm;
  }

  void setMood(GameMood newMood) {
    state = newMood;
  }
}
