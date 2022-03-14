import 'package:flutter/material.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  static final lightTheme = ThemeData(
    primaryColor: Color(0xFF78909c),
    scaffoldBackgroundColor: const Color(0xFFa7c0cd),
    backgroundColor: Color(0xFFc1d5e0),
    appBarTheme: const AppBarTheme(color: const Color(0xFF4b636e)),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF62757f),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    fontFamily: "FredokaOne",
  );

  static final light2Theme = ThemeData(
    primaryColor: Color(0xFFffeb3b),
    scaffoldBackgroundColor: const Color(0xFFffee58),
    backgroundColor: const Color(0xFFffff8b),
    appBarTheme: const AppBarTheme(color: const Color(0xFFc9bc1f)),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFFffff8b),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    fontFamily: "FredokaOne",
  );

  static final light3Theme = ThemeData(
    primaryColor: Color(0xFF4e342e),
    scaffoldBackgroundColor: const Color(0xFF7b5e57),
    backgroundColor: Color(0xFF6a4f4b),
    appBarTheme: const AppBarTheme(color: const Color(0xFF260e04)),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF3e2723),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    fontFamily: "FredokaOne",
  );

  static final light4Theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0336FF),
    appBarTheme: const AppBarTheme(color: const Color(0xFF0336FF)),
    backgroundColor: const Color(0xFFFF0266),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFFFF0266),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    fontFamily: "FredokaOne",
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    fontFamily: "FredokaOne",
  );
}
