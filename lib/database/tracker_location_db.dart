import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_location.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:sqflite/sqflite.dart';

class TrackerLocationDB {
  static String tableName = 'tracker_location';

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

  /// Add a new tracker location the database
  static Future add(Database db, String trackerUUID, TrackerLocation location) async {
    await db.execute('INSERT INTO tracker_location (tracker_id, latitude, longitude, timestamp, acc, gps, speed) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [trackerUUID, location.latitude, location.longitude, location.timestamp.toIso8601String(), location.acc, location.gps, location.speed]);
  }

  /// Get a list of all location available in for a specific tracker in database
  static Future<List<TrackerLocation>> list(Database db, String trackerUUID) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM tracker_location WHERE tracker_location.tracker_id = ?', [trackerUUID]);
    List<TrackerLocation> locations = [];

    for (int i = 0; i < list.length; i++) {
      locations.add(parse(list[i]));
    }

    return locations;
  }

  /// Get the last location of a specific tracker from database
  static Future<TrackerLocation> getLast(Database db, String trackerUUID) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM tracker_location WHERE tracker_location.tracker_id = ? ORDER BY tracker_location.timestamp DESC', [trackerUUID]);

    if (list.isEmpty) {
      throw Exception("No location available for the tracker");
    }

    return parse(list[0]);
  }

  /// Parse database retrieved data into a usable object.
  static TrackerLocation parse(Map<String, Object?> values) {
    TrackerLocation location = TrackerLocation();

    location.id = int.parse(values['id'].toString());
    location.timestamp = DateTime.parse(values['timestamp'].toString());
    location.latitude = double.parse(values['latitude'].toString());
    location.longitude = double.parse(values['longitude'].toString());
    location.speed = double.parse(values['speed'].toString());

    return location;
  }

  static Future<void> test(Database db) async {
    Tracker tracker = Tracker();
    await TrackerDB.add(db, tracker);

    List<Future> addFuture = [];
    const int size = 10;
    for (int i = 0; i < size; i++) {
      TrackerLocation location = TrackerLocation();
      location.latitude = 1.0;
      location.longitude = 1.0;
      location.speed = 1.0;
      addFuture.add(add(db, tracker.uuid, location));
    }
    await Future.wait(addFuture);

    List<TrackerLocation> locations = await list(db, tracker.uuid);

    print(locations[0].getGoogleMapsURL());
    print(locations);
  }


}