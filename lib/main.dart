import 'package:flutter/material.dart';
import 'app.dart';
import 'database/database.dart';

void main() {
  Database.create();

  runApp(const TrackerApp());
}



