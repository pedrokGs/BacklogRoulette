import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodSelectorTab extends ConsumerStatefulWidget {
  const MoodSelectorTab({super.key});

  @override
  ConsumerState<MoodSelectorTab> createState() => _MoodSelectorTabState();
}

class _MoodSelectorTabState extends ConsumerState<MoodSelectorTab> {
  static const Map<GameMood, IconData> _moodIcons = {
    GameMood.tranquilo: Icons.spa_outlined,
    GameMood.eletrizante: Icons.bolt,
    GameMood.cerebral: Icons.psychology,
    GameMood.imersivo: Icons.auto_awesome,
    GameMood.tenso: Icons.warning_amber_rounded,
    GameMood.competitivo: Icons.emoji_events_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(rouletteNotifier.notifier);

    ref.watch(rouletteNotifier);

    final currentMood = notifier.currentMood;

    return Container(
      color: const Color(0xFF0F1115),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: Text(
              "COMO VOCÊ ESTÁ SE SENTINDO?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Russo One',
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: GameMood.values.length,
              itemBuilder: (context, index) {
                final mood = GameMood.values[index];
                final isSelected = mood == currentMood;

                return GestureDetector(
                  onTap: () {
                    ref.read(rouletteNotifier.notifier).updateMood(mood);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white10,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _moodIcons[mood],
                          size: 32,
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white38,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mood.name.toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Text(
                          _getMoodSubtitle(mood),
                          style: TextStyle(
                            color: isSelected ? Colors.white54 : Colors.white24,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMoodSubtitle(GameMood mood) {
    switch (mood) {
      case GameMood.tranquilo: return "Relax e paz";
      case GameMood.eletrizante: return "Adrenalina pura";
      case GameMood.cerebral: return "Pense e vença";
      case GameMood.imersivo: return "Outro mundo";
      case GameMood.tenso: return "Cuidado...";
      case GameMood.competitivo: return "Glória eterna";
    }
  }
}