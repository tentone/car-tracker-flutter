import 'dart:io';

import 'package:cartracker/database/database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

Future<void> main() async {
  Directory di = await getApplicationDocumentsDirectory();
  print(di);

  runApp(App());



  Data.create();
}



