import 'package:cartracker/database/database.dart';
import 'package:cartracker/utils/sms.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  runApp(App());

  await DataBase.get();
  await Geolocator.requestPermission();
  await SMSUtils.importReceived();

  SMSUtils.startListener();
}
