/// Database backup class contains auxiliary classes to export and import database to external services.
///
/// Services are managed by the user (e.g. Google Driver, iCloud).
class DatabaseBackup {
  static exportGoogleDrive() async {
    DriveHelper drive = DriveHelper();
    await drive.signInAndInit(DriveScopes.app);
    if (drive.connectionState == ConnectionState.done && !drive.hasError) {
      // TODO <ADD CODE HERE>
    }
  }

}