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

      title: const Text(
        "Include free games",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text("Should free games be searched?"),

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
