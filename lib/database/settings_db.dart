import 'package:cartracker/data/settings.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDB {
  static String tableName = 'settings';

  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ' + tableName + '('
        'id INTEGER PRIMARY KEY,'
        'locale TEXT'
        ')');

    Settings settings = Settings();

    try {
      await db.execute('INSERT INTO ' + tableName + ' (locale, theme) VALUES (?, ?)', [settings.locale, settings.theme]);
    } catch(e) {}
  }

  static Future update(Database db, Settings settings) async {
    await db.execute('UPDATE ' + tableName + ' SET locale=?, theme=? WHERE id=0', [settings.locale, settings.theme]);
  }

  static Future<Settings> get(Database db, String uuid) async {
    List<Map<String, Object?>> values = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE id=0', [uuid]);

    return parse(values[0]);
  }

  /// Parse database retrieved data into a usable object.
  static Settings parse(Map<String, Object?> values) {
    Settings settings = Settings();

    settings.locale = values['locale'].toString();
    settings.theme = values['theme'].toString();

    return settings;
  }

}