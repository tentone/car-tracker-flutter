import 'package:flutter/material.dart';

class Themes {
  /// Indicate if dark mode is used
  static ThemeMode mode = ThemeMode.system;

  /// Light/white theme configurations
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(primary: Colors.blue, secondary: Colors.blue),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      ));

  /// Dark theme configurations
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(primary: Colors.blue, primaryVariant: Colors.blueAccent, secondary: Colors.blue, secondaryVariant: Colors.blueAccent),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ));
}
