import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncludeFreeGamesNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
