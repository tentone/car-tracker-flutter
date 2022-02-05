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

    if (!await SettingsDB.has(db)) {
      await db.execute('INSERT INTO ' + tableName + ' (id, locale, theme) VALUES (0, ?, ?)', [Settings.global.locale, Settings.global.theme.index]);
    } else {
      await SettingsDB.get(db);
    }
  }

  /// Update settings in database
  static Future update(Database db) async {
    await db.execute('UPDATE ' + tableName + ' SET locale=?, theme=? WHERE id=0', [Settings.global.locale, Settings.global.theme.index]);
  }

  static Future<bool> has(Database db) async {
    List values = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE id=0');

    return values.isNotEmpty;
  }

  /// Get settings from database
  static Future<void> get(Database db) async {
    List<Map<String, Object?>> values = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE id=0');

    parse(values[0]);
  }

  /// Parse database retrieved data into a usable object.
  static void parse(Map<String, Object?> values) {
    Settings.global.locale = values['locale'].toString();
    Settings.global.theme = ThemeMode.values[int.parse(values['theme'].toString())];
  }
}
