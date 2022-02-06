import 'package:cartracker/locale/locale_pt.dart';
import 'package:flutter/material.dart';
import 'locale_en.dart';

/// Class to manage locale related information
class Locales {
  /// Flutter locale object
  final Locale locale;

  const Locales(this.locale);

  /// Locales available in the platform indexed by language code.
  static Map<String, Map<String, String>> values = {'en': LocaleEN, 'pt': LocalePT};

  /// Active locale code
  static String code = 'en';

  /// Supported locale codes
  static const List<Locale> supported = [Locale('en', ''), Locale('pt', '')];

  /// Get the locale to be used for a specific context.
  static Locales? of(BuildContext context) {
    return Localizations.of<Locales>(context, Locales);
  }

  /// Get a locale text value for a specific context, (cleaner locale access).
  static String get(String key, BuildContext context) {
    // Locale locale = Localizations.localeOf(context);
    // locale.languageCode

    String? value = Locales.values[Locales.code]?[key];
    if (value != null) {
      return value;
    }

    return key;
  }

  /// Get localized text from key.
  static String getValue(String key) {
    String? value = Locales.values[Locales.code]?[key];
    if (value != null) {
      return value;
    }

    return key;
  }

  /// Define the locale to be used by the application.
  static void setLocale(String code) {
    if (!Locales.values.containsKey(code)) {
      throw Exception('Locale is not registered, or does not exist.');
    }

    Locales.code = code;
  }

  /// Register a new locale entry in the system.
  ///
  /// Locale entries are indexed by their language code.
  static void register(String code, Map<String, String> data) {
    Locales.values[code] = data;
  }
}
