import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/router/test_router.dart';

/// Função helper para inicializar widget com escopo de provider, navegação e Material
Widget initializeWidget({
  required ProviderContainer container,
  required String initialLocation,
  bool shouldIncludeAuthentication = false,
}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      routerConfig: shouldIncludeAuthentication
          ? container.read(routerProvider)
          : createTestRouter(initialLocation: initialLocation),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}
