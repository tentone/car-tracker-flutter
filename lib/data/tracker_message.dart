enum MessageDirection {
  SENT, RECEIVED
}

class TrackerMessage {
  DateTime timestamp;

  MessageDirection direction;

  String data;

  TrackerMessage(this.direction, this.data, this.timestamp)
}