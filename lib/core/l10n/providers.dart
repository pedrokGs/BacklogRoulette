import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return ui.PlatformDispatcher.instance.locale;
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
