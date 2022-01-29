import 'package:cartracker/utils/sms_utils.dart';
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

  await Geolocator.requestPermission();
  await SMSUtils.importAll();

  SMSUtils.startListener();
}



