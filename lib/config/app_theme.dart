import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'inter',
      // TODO: Add page trasition theme.

      scaffoldBackgroundColor: AppColours.verylightTeal,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColours.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: AppColours.veryLightVividTeal, width: 2, )),


        
      ),
      
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColours.white ,
        width: 250.w
            ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp),
        displayMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp),
        bodyMedium: TextStyle(fontSize: 13.sp, color: AppColours.grey, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontWeight: FontWeight.w700, fontSize:  15.sp),
        titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp,),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          color: AppColours.grey,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontSize: 15.sp,
          color: AppColours.grey,
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColours.vividOrange)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColours.vividOrange),
        ),
      ),
    );
  }
}
