import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'FiraSans',
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight(700), fontSize: 30),
        displayMedium: TextStyle(fontWeight: FontWeight(500)),
        bodyMedium: TextStyle(fontSize: 14),
        titleSmall: TextStyle(fontWeight: FontWeight(400)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColour.veryLightVividTeal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColour.vividTeal),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColour.vividOrange),
        ),
      ),
    );
  }
}
