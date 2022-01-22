import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/settings_db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

/// Stores the application settings
class Settings extends ChangeNotifier {
  static Settings global = Settings();

  /// Locale of the application
  String _locale = 'en';
  String get locale {return _locale;}

  set locale(String value) {
    this._locale = value;
    this.update();
  }

  /// Theme to use in the application
  bool _darkMode = true;
  bool get darkMode {return _darkMode;}

  set darkMode(bool value) {
    this._darkMode = value;
    this.update();
  }

  /// Update settings on database and notify listeners for changes.
  ///
  /// Called after any parameter in the settings object has been changed.
  void update() {
    DataBase.get().then((Database? db) {
      SettingsDB.update(db!, this);
    });
    notifyListeners();
  }
}