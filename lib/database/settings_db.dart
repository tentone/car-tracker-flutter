import 'package:cartracker/data/settings.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDB {
  static String tableName = 'settings';

  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ' +
        tableName +
        '('
            'id INTEGER PRIMARY KEY,'
            'locale TEXT,'
            'theme INT'
            ')');

    try {
      Settings settings = Settings();
      await db.execute(
          'INSERT INTO ' + tableName + ' (locale, theme) VALUES (?, ?)',
          [settings.locale, settings.theme.index]);
    } catch (e) {}

    try {
      Settings.global = await SettingsDB.get(db);
    } catch (e) {}
  }

  /// Update settings in database
  static Future update(Database db, Settings settings) async {
    await db.execute(
        'UPDATE ' + tableName + ' SET locale=?, theme=? WHERE id=0',
        [settings.locale, settings.theme.index]);
  }

  /// Get settings from database
  static Future<Settings> get(Database db) async {
    List<Map<String, Object?>> values =
        await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE id=0');

    return parse(values[0]);
  }

  /// Parse database retrieved data into a usable object.
  static Settings parse(Map<String, Object?> values) {
    Settings settings = Settings();

    settings.locale = values['locale'].toString();
    settings.theme = ThemeMode.values[int.parse(values['theme'].toString())];

    return settings;
  }
}
