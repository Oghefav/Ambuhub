import 'package:another_flushbar/flushbar.dart';
import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppFlushBarType { success, error, }

void showCustomFlushBar(
  BuildContext context, {
  required String message,
  required String title,
  required AppFlushBarType type,
}) {
  final (Color bg) = switch (type) {
    AppFlushBarType.success => (AppColours.snackBarBackground),
    AppFlushBarType.error => (AppColours.snackBarErrorBackground),
  };
  final (Color border) = switch (type) {
    AppFlushBarType.success => (AppColours.snackBarBorder),
    AppFlushBarType.error => (AppColours.snackBarErrorBorder),
  };
  final (Color foreground) = switch (type) {
    AppFlushBarType.success => (AppColours.snackBarGreen),
    AppFlushBarType.error => (AppColours.snackBarBrown),
  };

  Flushbar(
    message: message,
    messageColor: foreground,

    borderColor: border,
    backgroundColor: bg,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    mainButton: IconButton(onPressed: () {}, icon: Icon(Icons.close, color: foreground)),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(12.w),
    borderRadius: BorderRadius.circular(15.r), 
  ).show(context);
}
