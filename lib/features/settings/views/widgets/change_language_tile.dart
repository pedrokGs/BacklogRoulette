import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/core/l10n/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeLanguageTile extends ConsumerWidget {
  const ChangeLanguageTile({super.key});

  String getLanguageName(String code) {
    return switch (code) {
      'pt' => 'Português',
      'pt_BR' => 'Português (Brasil)',
      'en' => 'English',
      'es' => 'Español',
      'fr' => 'Français',
      'zh' => '简体中文',
      _ => code.toUpperCase(),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      title: Text(
        AppLocalizations.of(context)!.settings_Screen_language_tile,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        getLanguageName(currentLocale.languageCode),
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
        _showLanguageSelection(context, ref, currentLocale);
      },

      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    );
  }

  void _showLanguageSelection(
    BuildContext context,
    WidgetRef ref,
    Locale current,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
              _LanguageOption(
                label: 'Português (Brasil)',
                code: 'pt_BR',
                selected:
                    current.languageCode == 'pt' && current.countryCode == 'BR',
                onTap: () => _updateLocale(ref, context, Locale("pt", "BR")),
              ),
              _LanguageOption(
                label: 'Português',
                code: 'pt',
                selected:
                    current.languageCode == 'pt' && current.countryCode == "PT",
                onTap: () => _updateLocale(ref, context, Locale("pt", "PT")),
              ),
              _LanguageOption(
                label: 'English',
                code: 'en',
                selected: current.languageCode == 'en',
                onTap: () => _updateLocale(ref, context, Locale('en')),
              ),
              _LanguageOption(
                label: "Espanõl",
                code: 'es',
                selected: current.languageCode == 'es',
                onTap: () => _updateLocale(ref, context, Locale('es')),
              ),
              _LanguageOption(
                label: 'Français',
                code: 'fr',
                selected: current.languageCode == 'fr',
                onTap: () => _updateLocale(ref, context, Locale('fr')),
              ),
              _LanguageOption(
                label: '简体中文',
                code: 'zh',
                selected: current.languageCode == 'zh',
                onTap: () => _updateLocale(ref, context, Locale('zh')),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateLocale(WidgetRef ref, BuildContext context, Locale locale) {
    HapticFeedback.lightImpact();
    ref.read(localeNotifierProvider.notifier).setLocale(locale);
    Navigator.pop(context);
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  String getFlag(String code) {
    return switch (code) {
      'pt' => '🇵🇹',
      'pt_BR' => '🇧🇷',
      'en' => '🇺🇸',
      'es' => '🇪🇸',
      'fr' => '🇫🇷',
      'zh' => '🇨🇳',
      _ => '🌐',
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(getFlag(code), style: const TextStyle(fontSize: 24)),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
