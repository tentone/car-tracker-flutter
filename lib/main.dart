import 'package:flutter/material.dart';
import 'app.dart';
import 'database/database.dart';

void main() {
  runApp(const TrackerApp());

  Database.create();
}



