import 'package:flutter/material.dart';
import 'app.dart';
import 'database/database.dart';

Future<void> main() async {
  Database.create();

  runApp(App());
}



