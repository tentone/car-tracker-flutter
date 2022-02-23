import 'package:drive_helper/drive_helper.dart';


/// Database backup class contains auxiliary classes to export and import database to external services.
///
/// Services are managed by the user (e.g. Google Driver, iCloud).
class DatabaseBackup {
  static exportGoogleDrive() async {
    DriveHelper drive = DriveHelper();
    await drive.signInAndInit([DriveScopes.app]);

    DateTime now = DateTime.now();

    drive.createFile('car_tracker_' + now.year.toString() + now.month.toString() + now.day.toString() + ".db", "application/x-sqlite3");
  }

}