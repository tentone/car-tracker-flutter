import 'dart:io';

import 'package:cartracker/database/database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

Future<void> main() async {
  runApp(App());

  Data.create();
}



