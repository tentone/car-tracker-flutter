import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

/// Show tracker data alongside with the last known position
class TrackerLastPosition {
  /// Tracker data
  Tracker tracker;

  /// Tracker last known position
  TrackerPosition position;

  TrackerLastPosition(this.tracker, this.position);
}

class TrackerPositionDB {
  static String tableName = 'tracker_position';

  static Future<void> migrate(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ' +
        tableName +
        ' ('
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
  static Future add(Database db, String trackerUUID, TrackerPosition location) async {
    await db.execute('INSERT INTO ' + tableName + ' (tracker_id, latitude, longitude, timestamp, acc, gps, speed) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [trackerUUID, location.latitude, location.longitude, location.timestamp.toIso8601String(), location.acc, location.gps, location.speed]);
  }

  /// Get a list of all location available in for a specific tracker in database
  static Future<List<TrackerPosition>> list(Database db, String trackerUUID, {String sortAttribute = 'timestamp', String sortDirection = 'DESC'}) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE tracker_id = ? ORDER BY ' + sortAttribute + ' ' + sortDirection, [trackerUUID]);
    List<TrackerPosition> locations = [];

    for (int i = 0; i < list.length; i++) {
      locations.add(parse(list[i]));
    }

    return locations;
  }

  /// Get the last location of a specific tracker from database
  static Future<List<TrackerLastPosition>> getAllTrackerLastPosition(Database db, {String sortAttribute = 'name', String sortDirection = 'DESC'}) async {
    List<Tracker> trackers = await TrackerDB.list(db, sortAttribute: sortAttribute, sortDirection: sortDirection);
    List<TrackerLastPosition> list = [];

    for (int i = 0; i < trackers.length; i++) {
      try {
        TrackerPosition position = await TrackerPositionDB.getLast(db, trackers[i].uuid);
        list.add(TrackerLastPosition(trackers[i], position));
      } catch (e) {}
    }

    return list;
  }

  /// Get the last location of a specific tracker from database
  static Future<TrackerPosition> getLast(Database db, String trackerUUID, {String sortAttribute = 'timestamp', String sortDirection = 'DESC'}) async {
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM ' + tableName + ' WHERE tracker_id = ? ORDER BY ' + sortAttribute + ' ' + sortDirection, [trackerUUID]);

    if (list.isEmpty) {
      throw Exception('No location available for the tracker');
    }

    return parse(list[0]);
  }

  /// Parse database retrieved data into a usable object.
  static TrackerPosition parse(Map<String, Object?> values) {
    TrackerPosition location = TrackerPosition();

    location.id = int.parse(values['id'].toString());
    location.timestamp = DateTime.parse(values['timestamp'].toString());
    location.latitude = double.parse(values['latitude'].toString());
    location.longitude = double.parse(values['longitude'].toString());
    location.speed = double.parse(values['speed'].toString());

    return location;
  }

  /// Test functionality of the location storage
  static Future<void> test(Database db) async {
    if (kDebugMode) {
      Tracker tracker = Tracker();
      await TrackerDB.add(db, tracker);

      List<Future> addFuture = [];
      const int size = 10;
      for (int i = 0; i < size; i++) {
        TrackerPosition location = TrackerPosition();
        addFuture.add(add(db, tracker.uuid, location));
      }
      await Future.wait(addFuture);

      List<TrackerPosition> locations = await list(db, tracker.uuid);

      print(locations[0].getGoogleMapsURL());
      print(locations);
    }
  }
}
