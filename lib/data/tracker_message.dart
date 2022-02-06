/// Direction of a SMS exchanged with a tracker.
enum MessageDirection {
  SENT,

  RECEIVED
}

/// Message received or sent by the tracker
class TrackerMessage {
  /// ID of the tracker message
  int id = -1;

  /// Timestamp of the message
  DateTime timestamp;

  /// Direction of the message
  MessageDirection direction;

  /// The content of the message
  String data;

  TrackerMessage(this.direction, this.data, this.timestamp);
}
