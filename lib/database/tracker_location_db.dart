import 'package:sqflite/sqflite.dart';

class TrackerLocationDB {
  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE tracker_location ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'latitude REAL,'
      'longitude REAL,'
      'timestamp STRING,'
      'acc INTEGER,'
      'gps INTEGER,'
      'speed REAL,'
      'CONSTRAINT fk_tracker FOREIGN KEY tracker_id REFERENCES tracker(id)'
    ')');
  }
}