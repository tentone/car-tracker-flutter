import 'package:sms_advanced/sms_advanced.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Listen to incoming SMS messages.
  static void listen() {
    SmsReceiver receiver = SmsReceiver();
    if(receiver.onSmsReceived != null) {
      receiver.onSmsReceived?.listen((SmsMessage ?msg){
        print(msg?.body);
      });
    }
  }

  /// Send a SMS to an address (phone number)
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

  static Future getReceived(String address) async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.querySms(
      kinds: [SmsQueryKind.Inbox],
      address: address
    );

    for(int i = 0; i < messages.length; i++) {
      print(messages[i].address);
      print(messages[i].body);
    }
  }

  /// Get all SMS received by the device.
  static Future getAll() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;

    for(int i = 0; i < messages.length; i++) {
      print(messages[i].address);
      print(messages[i].body);
    }
  }
}