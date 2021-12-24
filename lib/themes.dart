import 'package:flutter/material.dart';

class Themes{
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
          primary: Colors.blue
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      )
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: Colors.blue,
        secondary: Colors.blue
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      )
  );
}