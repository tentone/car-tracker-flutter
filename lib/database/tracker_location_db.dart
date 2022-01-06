import 'package:sqflite/sqflite.dart';

class TrackerLocationDB {
  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS tracker_location ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'tracker_id STRING,'
      'latitude REAL,'
      'longitude REAL,'
      'timestamp STRING,'
      'acc INTEGER,'
      'gps INTEGER,'
      'speed REAL,'
      'FOREIGN KEY(tracker_id) REFERENCES tracker(id)'
    ')');
  }


}