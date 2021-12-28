import 'package:sms_advanced/sms_advanced.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Method to send SMS to a list of recipients.
  static void send(String content, String address) async {
    SmsSender sender = new SmsSender();

    SmsMessage message = new SmsMessage(address, content);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }
}