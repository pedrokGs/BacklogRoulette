import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/models/enums/game_mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodSelectorTab extends ConsumerStatefulWidget {
  const MoodSelectorTab({super.key});

  @override
  ConsumerState<MoodSelectorTab> createState() => _MoodSelectorTabState();
}

class _MoodSelectorTabState extends ConsumerState<MoodSelectorTab> {
  static const Map<GameMood, IconData> _moodIcons = {
    GameMood.calm: Icons.spa_outlined,
    GameMood.electric: Icons.bolt,
    GameMood.brainiac: Icons.psychology,
    GameMood.immersive: Icons.auto_awesome,
    GameMood.tense: Icons.warning_amber_rounded,
    GameMood.competitive: Icons.emoji_events_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(rouletteNotifier.notifier);

    ref.watch(rouletteNotifier);

    final currentMood = notifier.currentMood;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.mood_tab_screen_title,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.mood_tab_screen_subtitle,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: GameMood.values.length,
                  itemBuilder: (context, index) {
                    final theme = Theme.of(context);
                    final colorScheme = theme.colorScheme;

                    final mood = GameMood.values[index];
                    final isSelected = mood == currentMood;

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ref.read(rouletteNotifier.notifier).updateMood(mood);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primaryContainer
                              : theme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : theme.dividerColor.withValues(alpha: 0.1),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
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
                                  : Colors.grey[400],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _getMoodTitle(mood),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getMoodSubtitle(mood),
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer.withValues(
                                        alpha: 0.7,
                                      )
                                    : Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMoodTitle(GameMood mood) {
    switch (mood) {
      case GameMood.calm:
        return AppLocalizations.of(context)!.mood_calm_title;
      case GameMood.electric:
        return AppLocalizations.of(context)!.mood_electric_title;
      case GameMood.brainiac:
        return AppLocalizations.of(context)!.mood_brainiac_title;
      case GameMood.immersive:
        return AppLocalizations.of(context)!.mood_immersive_title;
      case GameMood.tense:
        return AppLocalizations.of(context)!.mood_tense_title;
      case GameMood.competitive:
        return AppLocalizations.of(context)!.mood_competitive_title;
    }
  }

  String _getMoodSubtitle(GameMood mood) {
    switch (mood) {
      case GameMood.calm:
        return AppLocalizations.of(context)!.mood_calm_subtitle;
      case GameMood.electric:
        return AppLocalizations.of(context)!.mood_electric_subtitle;
      case GameMood.brainiac:
        return AppLocalizations.of(context)!.mood_brainiac_subtitle;
      case GameMood.immersive:
        return AppLocalizations.of(context)!.mood_immersive_subtitle;
      case GameMood.tense:
        return AppLocalizations.of(context)!.mood_tense_subtitle;
      case GameMood.competitive:
        return AppLocalizations.of(context)!.mood_competitive_subtitle;
    }
  }
}
