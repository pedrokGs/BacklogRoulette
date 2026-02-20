import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/themes/providers.dart';

class SwitchThemeTile extends ConsumerWidget {
  const SwitchThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      title: Text(
        AppLocalizations.of(context)!.settings_screen_theme_mode_title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        isDark
            ? AppLocalizations.of(
                context,
              )!.settings_screen_theme_mode_subtitle_dark
            : AppLocalizations.of(
                context,
              )!.settings_screen_theme_mode_subtitle_light,
        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
      ),

      leading: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: RotationTransition(turns: anim, child: child),
        ),
        child: Icon(
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          key: ValueKey(isDark),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      onTap: () {
        HapticFeedback.selectionClick();
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },

      trailing: Switch.adaptive(
        value: isDark,
        activeThumbColor: Theme.of(context).colorScheme.primary,
        onChanged: (_) {
          HapticFeedback.lightImpact();
          ref.read(themeNotifierProvider.notifier).toggleTheme();
        },
      ),
    );
  }
}
