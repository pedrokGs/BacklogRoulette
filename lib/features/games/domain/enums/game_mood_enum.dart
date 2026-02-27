import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Representa alguns 'moods' para calcular a lógica de peso da roleta
enum GameMood { calm, electric, brainiac, immersive, tense, competitive }

extension GameMoodExtension on GameMood {
  String title(BuildContext context) {
    switch (this) {
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

  String subtitle(BuildContext context) {
    switch (this) {
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

  IconData icon(BuildContext context, {bool active = false}) {
    switch (this) {
      case GameMood.calm:
        return active ? Icons.spa : Icons.spa_outlined;
      case GameMood.electric:
        return active ? Icons.bolt : Icons.bolt_outlined;
      case GameMood.brainiac:
        return active ? Icons.psychology : Icons.psychology_outlined;
      case GameMood.immersive:
        return active ? Icons.auto_awesome : Icons.auto_awesome_outlined;
      case GameMood.tense:
        return active ? Icons.warning : Icons.warning_amber_outlined;
      case GameMood.competitive:
        return active ? Icons.emoji_events : Icons.emoji_events_outlined;
    }
  }
}
