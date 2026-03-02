import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget initializeWidget(Widget widget, {ProviderContainer? container}) {
  final app = MaterialApp(
    home: widget,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('en'),
  );

  if (container != null) {
    return UncontrolledProviderScope(container: container, child: app);
  }

  return ProviderScope(child: app);
}
