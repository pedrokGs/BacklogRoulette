import 'package:backlog_roulette/features/settings/domain/config/available_languages.dart';
import 'package:backlog_roulette/features/settings/domain/controllers/language_notifier.dart';
import 'package:backlog_roulette/features/settings/presentation/widgets/language_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget utilizado como BottomSheet
///
/// Retorna uma lista contendo todas as linguagens que o usuário pode selecionar
class LanguageSelectionSheet extends ConsumerWidget {
  const LanguageSelectionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageNotifierProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableLanguages.length,
              itemBuilder: (context, index) {
                final lang = availableLanguages[index];
                final isSelected = lang.locale == currentLanguage.locale;

                return LanguageOption(
                  language: lang,
                  isSelected: isSelected,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ref
                        .read(languageNotifierProvider.notifier)
                        .setLanguage(lang);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
