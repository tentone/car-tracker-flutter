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
  static Database? db;

  /// Create database structures
  static Future<void> create() async {
    String path = join(await getDatabasesPath(), DataBase.name);
    
    DataBase.db = await openDatabase(path, version: 1, onOpen: (Database db) async {
      await TrackerDB.migrate(db);
      await TrackerLocationDB.migrate(db);
      await TrackerMessageDB.migrate(db);
    });


    // // Update some record
    // int? count = await database.rawUpdate('UPDATE Test SET name = ?, value = ? WHERE name = ?', ['updated name', '9876', 'some name']);
    // print('updated: $count');
    //
    // // Get the records
    // List<Map> list = await database.rawQuery('SELECT * FROM Test');
    // print(list);
    //
    // // Count the records
    // count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
    //
    // // Delete a record
    // count = await database.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
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
