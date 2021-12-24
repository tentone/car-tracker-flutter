import 'package:flutter_sms/flutter_sms.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Method to send SMS to a list of recipients.
  void _sendSMS(String message, List<String> recipents) async {
    String result = await sendSMS(message: message, recipients: recipents).catchError((onError) {
      print(onError);
    });
    print(result);
  }
}