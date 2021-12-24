import 'locale_en.dart';

/// Class to manage locale related information
class Locale {
  /// Locales available in the platform indexed by language code.
  static Map<String, Map<String, String>> locales = {
    'en': LocaleEN
  };

  /// Active locale
  static String locale = 'en';

  /// Get localized text from key
  static String get(String key) {
    return '';
  }

  /// Register a new locale entry in the system.
  ///
  /// Locale entries are indexed by their language code.
  static void register(String code, Map<String, String> data) {
    Locale.locales[code] = data;
  }
}