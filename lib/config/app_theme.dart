import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'FiraSans',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight(700),
          fontSize: 30,
        ),
        bodyMedium: TextStyle(
          fontSize: 14
        )
      )
      );
  }
}
