import 'dart:async';

import 'package:flutter/material.dart';

/// Notifica o router para se recarregar
///
/// Usado para redirecionar usuário por meio da stream authUserChanges
class RouterRefresher extends ChangeNotifier {
  RouterRefresher(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
