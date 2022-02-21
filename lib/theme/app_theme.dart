import 'package:flutter/material.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF13B9FF),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}
