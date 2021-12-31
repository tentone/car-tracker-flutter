import 'package:sqflite/sqflite.dart';

class TrackerMessageDB {
  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE tracker_location ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'tracker_id STRING,'
      'direction INTEGER,'
      'timestamp STRING,'
      'data STRING,'
      'CONSTRAINT fk_tracker FOREIGN KEY tracker_id REFERENCES tracker(id)'
    ')');
  }
}