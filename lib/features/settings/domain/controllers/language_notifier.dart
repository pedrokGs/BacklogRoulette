import 'dart:ui' as ui;

import 'package:backlog_roulette/features/settings/domain/config/available_languages.dart';
import 'package:backlog_roulette/features/settings/domain/entities/language_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Gerencia a linguagem seleciona pelo usuário
///
/// Inicialmente retorna a linguagem do sistema
class LanguageNotifier extends Notifier<LanguageModel> {
  @override
  LanguageModel build() {
    final currentLocale = ui.PlatformDispatcher.instance.locale;

    return availableLanguages.firstWhere(
      (element) => element.locale == currentLocale,
      orElse: () => availableLanguages.first,
    );
  }

  /// Seta o idioma atual para o novo
  void setLanguage(LanguageModel language) {
    state = language;
  }
}

final languageNotifierProvider =
    NotifierProvider<LanguageNotifier, LanguageModel>(() {
      return LanguageNotifier();
    });
