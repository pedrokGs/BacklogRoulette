import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier simples apenas com uma bool para se deve incluir jogos free ou não
class IncludeFreeGamesNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
