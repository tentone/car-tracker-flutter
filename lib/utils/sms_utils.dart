import 'package:sms_advanced/sms_advanced.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Listen to incoming SMS messages.
  static void listen() {
    // TODO <ADD CODE HERE>

    SmsReceiver receiver = SmsReceiver();
    receiver.onSmsReceived?.listen((SmsMessage msg) => print(msg.body));

  }

  /// Method to send SMS to a list of recipients.
  static void send(String content, String address) async {
    SmsSender sender = SmsSender();

    SmsMessage message = SmsMessage(address, content);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }

  /// Get all SMS for a specific phone number
  static Future get(String address) async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    print(messages);
  }
}