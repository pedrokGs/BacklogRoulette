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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: Text(
              "COMO VOCÊ ESTÁ SE SENTINDO?",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
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
                final theme = Theme.of(context);
                final colorScheme = theme.colorScheme;

                final mood = GameMood.values[index];
                final isSelected = mood == currentMood;

                return GestureDetector(
                  onTap: () =>
                      ref.read(rouletteNotifier.notifier).updateMood(mood),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primaryContainer.withValues(alpha: 0.6)
                          : colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _moodIcons[mood],
                          size: 32,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mood.name.toUpperCase(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          _getMoodSubtitle(mood),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer.withValues(
                                    alpha: 0.7,
                                  )
                                : colorScheme.onSurfaceVariant,
                            fontSize: 12,
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
      case GameMood.tranquilo:
        return "Relax e paz";
      case GameMood.eletrizante:
        return "Adrenalina pura";
      case GameMood.cerebral:
        return "Pense e vença";
      case GameMood.imersivo:
        return "Outro mundo";
      case GameMood.tenso:
        return "Cuidado...";
      case GameMood.competitivo:
        return "Glória eterna";
    }
  }
}
