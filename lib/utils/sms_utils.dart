import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telephony/telephony.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Telephony instance used to interact with phone functionalities
  static Telephony telephony = Telephony.instance;

  /// Listen and process incoming SMS messages.
  ///
  /// Will also process messages received in background.
  static void startListener() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage msg) async {
        if (msg.body == null) {
          return;
        }

        // msg.date | msg.dateSent

        Database? db = await DataBase.get();
        List<Tracker> trackers = await TrackerDB.list(db!);

        for (int i = 0; i < trackers.length; i++) {

          if(msg.address == trackers[i].phoneNumber) {
            trackers[i].processSMS(msg.body!);
          }
        }
      },
      listenInBackground: false
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

  /// Get all SMS received by the device.
  static Future getAll() async {
    List<SmsMessage> messages = await telephony.getInboxSms();

    for(int i = 0; i < messages.length; i++) {
      print(messages[i].address);
      print(messages[i].body);
    }
  }

  /// Get SMS received from a specific address
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


}