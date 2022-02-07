import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_message.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/widget/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telephony/telephony.dart';

/// Utils to send and receive SMS messages.
class SMSUtils {
  /// Telephony instance used to interact with phone functionalities.
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

          Database? db = await DataBase.get();
          List<Tracker> trackers = await TrackerDB.list(db!);

          for (int i = 0; i < trackers.length; i++) {
            DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(msg.date!);

            if (trackers[i].compareAddress(msg.address!)) {
              if (kDebugMode) {
                print('CarTracker: Received message ' + msg.address! + ' (' + timestamp.toIso8601String() + ') -> ' + msg.body!.replaceAll('\n', ''));
              }
              trackers[i].processCommand(msg);
            }
          }
        },
        // onBackgroundMessage: backgroundMessageHandler,
        listenInBackground: false);
  }

  /// Import all messages received by the device.
  ///
  /// Should be called on application startup to process all stored messages.
  ///
  /// Can also be called after creating or changing the number of a tracker.
  static importAll() async {
    await SMSUtils.importReceived();
    await SMSUtils.importSent();
  }

  /// Get all SMS received by the device.
  ///
  /// Check if any stored messages correspond to tracker messages
  ///
  /// Import data from these messages.
  static Future importReceived() async {
    List<SmsMessage> messages = await telephony.getInboxSms(columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE], sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)]);

    Database? db = await DataBase.get();
    List<Tracker> trackers = await TrackerDB.list(db!);

    for (int i = 0; i < messages.length; i++) {
      SmsMessage msg = messages[i];
      for (int j = 0; j < trackers.length; j++) {
        if (trackers[j].compareAddress(msg.address!)) {
          DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(msg.date!);
          if (kDebugMode) {
            print('CarTracker: Found message ' + msg.address! + ' (' + timestamp.toIso8601String() + ') -> ' + msg.body!);
          }

          if (trackers[j].timestamp.isBefore(timestamp)) {
            if (kDebugMode) {
              print('CarTracker: Import received message ' + msg.address! + ' (' + timestamp.toIso8601String() + ') -> ' + msg.body!.replaceAll('\n', ''));
            }
            trackers[j].processCommand(msg);
          }
        }
      }
    }
  }

  /// Get all SMS sent to the device.
  static Future importSent() async {
    List<SmsMessage> messages = await telephony.getSentSms(sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)], columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE]);

    Database? db = await DataBase.get();
    List<Tracker> trackers = await TrackerDB.list(db!);

    for (int i = 0; i < messages.length; i++) {
      SmsMessage msg = messages[i];

      for (int j = 0; j < trackers.length; j++) {
        DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(msg.date!);
        if (trackers[j].compareAddress(msg.address!) && trackers[j].timestamp.isBefore(timestamp)) {
          if (kDebugMode) {
            print('CarTracker: Import sent message ' + msg.address! + ' (' + timestamp.toIso8601String() + ') -> ' + msg.body!.replaceAll('\n', ''));
          }
          trackers[j].addMessage(TrackerMessage(MessageDirection.SENT, msg.body!, timestamp));
        }
      }
    }
  }

  /// Send a SMS to an address (phone number)
  static void send(String content, String address, {BuildContext? context}) async {
    telephony.sendSms(
        to: address,
        message: content,
        statusListener: (SendStatus status) {
          if (context != null) {
            if (status == SendStatus.DELIVERED) {
              Modal.toast(context, Locales.get('commandSent', context));
            }
          }
        });
  }
}
