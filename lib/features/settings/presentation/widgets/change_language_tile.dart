import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/settings/domain/controllers/language_notifier.dart';
import 'package:backlog_roulette/features/settings/presentation/widgets/language_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cria um ListTile para mudar de linguagem
///
/// O usuário deve clicar no ListTile para abrir o menu de seleção
class ChangeLanguageTile extends ConsumerWidget {
  const ChangeLanguageTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLang = ref.watch(languageNotifierProvider);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      title: Text(
        AppLocalizations.of(context)!.settings_Screen_language_tile,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        currentLang.label,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.black54,
        ),
      ),

      leading: Icon(
        Icons.translate_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),

      onTap: () {
        HapticFeedback.selectionClick();
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => const LanguageSelectionSheet(),
        );
      },

      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    );
  }
}
