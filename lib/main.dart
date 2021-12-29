import 'package:flutter/material.dart';
import 'app.dart';
import 'database/database.dart';

Future<void> main() async {
  Data.create();

  runApp(App());
}



