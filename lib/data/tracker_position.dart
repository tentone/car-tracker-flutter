/// Stores a tracker location.
///
/// Stored in database and associated with the tracker.
class TrackerPosition {
  /// ID of the tracker location in database
  int id = -1;

  /// GPS latitude of the location
  double latitude = 0.0;

  /// GPS longitude of the location
  double longitude = 0.0;

  /// Timestamp at wich this location was obtained
  DateTime timestamp = DateTime.now();

  /// Flag indicates if the ACC (ignition) was active.
  bool acc = false;

  /// Indicates if the GPS signal is active.
  bool gps = false;

  /// Speed of the vehicle
  double speed = 0.0;

  /// Generate a google maps URL from the GPS position.
  ///
  /// Can be used to open the location in external application.
  String getGoogleMapsURL() {
    return 'http://maps.google.com/maps?q=' + this.latitude.toString() + ',' + this.longitude.toString();
  }
}
