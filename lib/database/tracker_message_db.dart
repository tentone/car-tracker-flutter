import 'package:sqflite/sqflite.dart';

class TrackerMessageDB {
  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS tracker_location ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'tracker_id STRING,'
      'direction INTEGER,'
      'timestamp STRING,'
      'data STRING,'
      'FOREIGN KEY(tracker_id) REFERENCES tracker(id)'
    ')');
  }
}