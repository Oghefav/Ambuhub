import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'inter',
      // TODO: Add page trasition theme.

      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp),
        displayMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp),
        bodyMedium: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontWeight: FontWeight.w700, fontSize:  15.sp),
        titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp,),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColours.veryLightVividTeal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColours.vividTeal),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColours.vividOrange),
        ),
      ),
    );
  }
}
