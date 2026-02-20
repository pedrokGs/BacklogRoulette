import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncludeFreeTile extends ConsumerWidget {
  const IncludeFreeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldInclude = ref.watch(includeFreeGamesNotifier);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      title: Text(
        AppLocalizations.of(
          context,
        )!.settings_screen_library_should_include_free_games_title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        AppLocalizations.of(
          context,
        )!.settings_screen_library_should_include_free_games_subtitle,
      ),

      leading: AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        transitionBuilder: (child, anim) =>
            FadeTransition(opacity: anim, child: child),
        child: Icon(
          shouldInclude ? Icons.attach_money : Icons.money_off,
          key: ValueKey(shouldInclude),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      onTap: () {
        HapticFeedback.selectionClick();
        ref.read(includeFreeGamesNotifier.notifier).toggle();
      },

      trailing: Switch.adaptive(
        value: shouldInclude,
        activeThumbColor: Theme.of(context).colorScheme.primary,
        onChanged: (_) {
          HapticFeedback.lightImpact();
          ref.read(includeFreeGamesNotifier.notifier).toggle();
        },
      ),
    );
  }
}
