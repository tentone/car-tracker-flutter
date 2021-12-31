import 'package:cartracker/data/tracker.dart';
import 'package:sqflite/sqflite.dart';

class TrackerDB {
  static String tableName = 'tracker';

  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS tracker('
      'uuid TEXT PRIMARY KEY,'
      'id TEXT,'
      'name TEXT,'
      'license_plate TEXT,'
      'chassis_number TEXT,'
      'model TEXT,'
      'color TEXT,'
      'phone_number TEXT,'
      'admin_number TEXT,'
      'sos_numbers TEXT,'
      'pin TEXT,'
      'speed_limit INTEGER,'
      'sleep_limit INTEGER,'
      'ignition_alarm INTEGER,'
      'power_alarm_sms INTEGER,'
      'power_alarm_call INTEGER,'
      'battery INTEGER,'
      'apn TEXT,'
      'iccid TEXT'
    ')');
  }

  /// Add a new tracker to the database
  static Future add(Database db, Tracker tracker) async {
    await db.execute('INSERT INTO tracker(uuid, id, name, license_plate, chassis_number,'
        'model, color, phone_number, admin_number, sos_numbers,'
        'pin, speed_limit, sleep_limit, ignition_alarm, power_alarm_sms,'
        'power_alarm_call, battery, apn, accid) VALUES (?, ?, ?)', []);
  }

  /// Get details of a tracker by its UUID
  static Future get(Database db, String uuid) async {

  }

  /// Delete a tracker by its UUID
  static Future delete(Database db, String uuid) async {

  }

  /// Get a list of all trackers available in database
  static Future<List<Tracker>> list(Database db) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM "table"');

    print(list);

    return [];
  }
}