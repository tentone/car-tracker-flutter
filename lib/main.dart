import 'package:cartracker/database/database.dart';
import 'package:cartracker/utils/sms.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'app.dart';
import 'package:geolocator/geolocator.dart';

/// Background message handler.
///
/// Used to process messages received when the application is on background
backgroundMessageHandler(SmsMessage message) async {
  // Handle background message
}

Future<void> main() async {
  runApp(App());

  await DataBase.get();
  await Geolocator.requestPermission();
  await SMSUtils.importReceived();

  SMSUtils.startListener();
}
