import 'dart:async';

import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/database/tracker_location_db.dart';
import 'package:cartracker/database/tracker_message_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Handle global database operations.
///
/// Database should be created and closed after operations are performed.
class DataBase {
  /// Name of the database file
  static String name = 'database.db';

  /// Global database object, should be closed before exiting.
  static Database ?db;

  /// Create database structures
  static Future<void> create() async {
    String path = join(await getDatabasesPath(), DataBase.name);
    
    DataBase.db = await openDatabase(path, version: 1, onOpen: (Database db) async {
      await TrackerDB.migrate(db);
      await TrackerLocationDB.migrate(db);
      await TrackerMessageDB.migrate(db);
    });

   // TrackerDB.test(db!);

  }

  /// Close the database
  static close() async {
    // Close the database
    await DataBase.db?.close();
  }

  /// Delete the database from the system.
  ///
  /// Useful for resetting the application back to its original settings.
  static delete() async {
    String path = join(await getDatabasesPath(), DataBase.name);

    await deleteDatabase(path);
  }
}
