import 'package:cartracker/data/tracker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TrackerDB {
  /// Used to notify changes to the tracker table
  static ChangeNotifier changeNotifier = ChangeNotifier();

  static String tableName = 'tracker';

  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ' +
        tableName +
        '('
            'uuid TEXT PRIMARY KEY,'
            'id TEXT,'
            'name TEXT,'
            'license_plate TEXT,'
            'chassis_number TEXT,'
            'model TEXT,'
            'color INTEGER,'
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
            'iccid TEXT,'
            'timestamp STRING'
            ')');
  }

  /// Add a new tracker to the database
  static Future add(Database db, Tracker tracker) async {
    await db.execute(
        'INSERT INTO ' +
            tableName +
            ' (uuid, id, name, license_plate, chassis_number,'
                'model, color, phone_number, admin_number, sos_numbers,'
                'pin, speed_limit, sleep_limit, ignition_alarm, power_alarm_sms,'
                'power_alarm_call, battery, apn, iccid, timestamp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          tracker.uuid,
          tracker.id,
          tracker.name,
          tracker.licensePlate,
          tracker.chassisNumber,
          tracker.model,
          tracker.color,
          tracker.phoneNumber,
          tracker.adminNumber,
          tracker.sosNumbers,
          tracker.pin,
          tracker.speedLimit,
          tracker.sleepLimit,
          tracker.ignitionAlarm,
          tracker.powerAlarmSMS,
          tracker.powerAlarmCall,
          tracker.battery,
          tracker.apn,
          tracker.iccid,
          tracker.timestamp.toIso8601String()
        ]);

    TrackerDB.changeNotifier.notifyListeners();
  }

  /// Update data from the tracker in database
  static Future update(Database db, Tracker tracker) async {
    await db.execute(
        'UPDATE ' +
            tableName +
            ' SET id=?, name=?, license_plate=?, chassis_number=?,'
                'model=?, color=?, phone_number=?, admin_number=?, sos_numbers=?,'
                'pin=?, speed_limit=?, sleep_limit=?, ignition_alarm=?, power_alarm_sms=?,'
                'power_alarm_call=?, battery=?, apn=?, iccid=?, timestamp=? WHERE uuid=?',
        [
          tracker.id,
          tracker.name,
          tracker.licensePlate,
          tracker.chassisNumber,
          tracker.model,
          tracker.color,
          tracker.phoneNumber,
          tracker.adminNumber,
          tracker.sosNumbers,
          tracker.pin,
          tracker.speedLimit,
          tracker.sleepLimit,
          tracker.ignitionAlarm,
          tracker.powerAlarmSMS,
          tracker.powerAlarmCall,
          tracker.battery,
          tracker.apn,
          tracker.iccid,
          tracker.timestamp.toIso8601String(),
          tracker.uuid
        ]);

    TrackerDB.changeNotifier.notifyListeners();
  }

  /// Get details of a tracker by its UUID
  static Future<Tracker> get(Database db, String uuid) async {
    List<Map<String, Object?>> values = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE uuid=?', [uuid]);
    if (values.isEmpty) {
      throw Exception('Tracker does not exist.');
    }

    return parse(values[0]);
  }

  /// Delete a tracker by its UUID
  static Future delete(Database db, String uuid) async {
    await db.rawDelete('DELETE FROM ' + tableName + ' WHERE uuid = ?', [uuid]);
    TrackerDB.changeNotifier.notifyListeners();
  }

  /// Count the number of trackers stored in database
  static Future<int?> count(Database db) async {
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ' + tableName));
  }

  /// Get a list of all trackers available in database
  static Future<List<Tracker>> list(Database db, {String sortAttribute = 'name', String sortDirection = 'ASC'}) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM ' + tableName + ' ORDER BY ' + sortAttribute + ' ' + sortDirection);
    List<Tracker> trackers = [];

    for (int i = 0; i < list.length; i++) {
      trackers.add(parse(list[i]));
    }

    return trackers;
  }

  /// Parse database retrieved data into a usable object.
  static Tracker parse(Map<String, Object?> values) {
    Tracker tracker = Tracker();

    tracker.uuid = values['uuid'].toString();
    tracker.id = values['id'].toString();
    tracker.name = values['name'].toString();
    tracker.licensePlate = values['license_plate'].toString();
    tracker.chassisNumber = values['chassis_number'].toString();
    tracker.model = values['model'].toString();
    tracker.color = int.parse(values['color'].toString());
    tracker.phoneNumber = values['phone_number'].toString();
    tracker.adminNumber = values['admin_number'].toString();
    // tracker.sosNumbers = values['sos_numbers'].toString();
    tracker.pin = values['pin'].toString();
    tracker.speedLimit = int.parse(values['speed_limit'].toString());
    tracker.sleepLimit = int.parse(values['sleep_limit'].toString());
    tracker.ignitionAlarm = int.parse(values['ignition_alarm'].toString()) == 1;
    tracker.powerAlarmSMS = int.parse(values['power_alarm_sms'].toString()) == 1;
    tracker.powerAlarmCall = int.parse(values['power_alarm_call'].toString()) == 1;
    tracker.battery = int.parse(values['battery'].toString());
    tracker.apn = values['apn'].toString();
    tracker.iccid = values['iccid'].toString();
    tracker.timestamp = DateTime.parse(values['timestamp'].toString());

    return tracker;
  }

  /// Test tracker database functionality.
  static test(Database db) async {
    if (kDebugMode) {
      const int size = 10;

      print(await count(db));

      List<Future> addFuture = [];
      for (int i = 0; i < size; i++) {
        addFuture.add(add(db, Tracker()));
      }
      await Future.wait(addFuture);

      print(await list(db));

      print(await count(db));
    }
  }
}
