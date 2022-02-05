import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/settings_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../themes.dart';

/// Singleton class to store the application settings
class Settings extends ChangeNotifier {
  /// Global settings object
  static Settings global = Settings();

  /// Locale of the application
  String get locale {
    return Locales.code;
  }

  set locale(String value) {
    Locales.code = value;
    this.update();
  }

  /// Theme to use in the application
  ThemeMode get theme {
    return Themes.mode;
  }

  set theme(ThemeMode value) {
    Themes.mode = value;
    this.update();
  }

  /// Update settings on database and notify listeners for changes.
  ///
  /// Called after any parameter in the settings object has been changed.
  void update() async {
    Database? db = await DataBase.get();
    await SettingsDB.update(db!);
    notifyListeners();
  }
}
