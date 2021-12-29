import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  /// Database object.
  static Data ?db;

  static String name = 'database.db';

  /// Create database structures
  static Future<void> create() async {
    String path = join(await getDatabasesPath(), Data.name);

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Test ('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'value INTEGER,'
          'num REAL'
      ')');
    });

    // Insert some records in a transaction
    await database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['name', 2, 3.1]);
      await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['name', 1, 4.2]);
    });

    // Update some record
    int? count = await database.rawUpdate('UPDATE Test SET name = ?, value = ? WHERE name = ?', ['updated name', '9876', 'some name']);
    print('updated: $count');

    // Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    print(list);

    // Count the records
    count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));

    // Delete a record
    count = await database.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);

    // Close the database
    await database.close();
  }

  /// Delete the database from the system.
  ///
  /// Useful for resetting the application back to its original settings.
  static delete() async {
    String path = join(await getDatabasesPath(), Data.name);

    await deleteDatabase(path);
  }
}
