import 'package:telephony/telephony.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  static Telephony telephony = Telephony.instance;

  /// Listen to incoming SMS messages.
  static void listen() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage msg) {
        print(msg.address);
        print(msg.body);
      },
      listenInBackground: false,
    );
  }

  /// Send a SMS to an address (phone number)
  static void send(String content, String address) async {
    telephony.sendSms(
        to: address,
        message: content,
        statusListener: (SendStatus status) {
          // SendStatus.DELIVERED
          // SendStatus.SENT
        }
    );
  }

  static Future getReceived(String address) async {
    List<SmsMessage> messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).like(address)
    );

    for(int i = 0; i < messages.length; i++) {
      print(messages[i].address);
      print(messages[i].body);
    }
  }

  /// Get all SMS received by the device.
  static Future getAll() async {
    List<SmsMessage> messages = await telephony.getInboxSms();

    for(int i = 0; i < messages.length; i++) {
      print(messages[i].address);
      print(messages[i].body);
    }
  }
}