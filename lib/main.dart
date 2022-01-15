import 'package:cartracker/utils/sms_utils.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  runApp(App());

  await SMSUtils.getAll();

  SMSUtils.startListener();
}



