import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'locales.dart';

/// The locale manager is used to manage the multiple locale options available.
///
/// The user can get locale objects to match their application locale from here.
class LocaleManager extends LocalizationsDelegate<Locales> {
  const LocaleManager();

  @override
  bool isSupported(Locale locale) {
    return Locales.values.keys.contains(locale.languageCode);
  }

  @override
  Future<Locales> load(Locale locale) {
    return SynchronousFuture<Locales>(Locales(locale));
  }

  @override
  bool shouldReload(LocaleManager old) {
    return false;
  }
}
