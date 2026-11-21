import 'package:backlog_roulette/features/settings/domain/controllers/language_notifier.dart';
import 'package:backlog_roulette/features/settings/presentation/widgets/language_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Permite escolher o idioma antes de entrar ou criar uma conta.
class AuthLanguageButton extends ConsumerWidget {
  const AuthLanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageNotifierProvider);

    return IconButton(
      tooltip: currentLanguage.label,
      icon: const Icon(Icons.translate_rounded),
      onPressed: () {
        HapticFeedback.selectionClick();
        showModalBottomSheet<void>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const LanguageSelectionSheet(),
        );
      },
    );
  }
}
