import 'dart:ui';

/// Classe simples para guardar dados de linguagem
class LanguageModel {
  final String label;
  final String flag;
  final Locale locale;

  const LanguageModel({
    required this.label,
    required this.flag,
    required this.locale,
  });
}
