/// Stores a tracker location.
///
/// Stored in database and associated with the tracker.
class TrackerLocation {
  /// GPS latitude of the location
  late double latitude;

  /// GPS longitude of the location
  late double longitude;

  /// Timestamp at wich this location was obtained
  late DateTime timestamp;

  /// Flag indicates if the ACC (ignition) was active.
  late bool acc;

  /// Indicates if the GPS signal is active.
  late bool gps;

  /// Speed of the vehicle
  late double speed;
}