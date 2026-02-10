import 'dart:async';

import 'package:flutter/material.dart';

/// Notify router to refresh itself
///
/// Used for consuming the authStateChanges Stream to redirect user
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
