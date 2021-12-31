import 'package:sqflite/sqflite.dart';

class TrackerDB {
  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE tracker('
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
      'ignitionAlarm INTEGER,'
      'power_alarm_sms INTEGER,'
      'power_alarm_call INTEGER,'
      'battery INTEGER,'
      'apn TEXT,'
      'iccid TEXT'
    ')');
  }
}