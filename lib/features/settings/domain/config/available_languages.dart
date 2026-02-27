import 'dart:ui';

import 'package:backlog_roulette/features/settings/domain/entities/language_model.dart';

/// Lista constante contendo todas as linguagens que o sistema suporta
const availableLanguages = [
  LanguageModel(
    label: 'Português (Brasil)',
    flag: '🇧🇷',
    locale: Locale('pt', 'BR'),
  ),
  LanguageModel(label: 'Português', flag: '🇵🇹', locale: Locale('pt', 'PT')),
  LanguageModel(label: 'English', flag: '🇺🇸', locale: Locale('en')),
  LanguageModel(label: 'Espanõl', flag: '🇪🇸', locale: Locale('es')),
  LanguageModel(label: 'Français', flag: '🇫🇷', locale: Locale('fr')),
  LanguageModel(label: '简体中文', flag: '🇨🇳', locale: Locale('zh')),
];
