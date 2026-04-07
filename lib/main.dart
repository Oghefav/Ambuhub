import 'package:ambuhub/config/app_theme.dart';
import 'package:ambuhub/features/auth/presentation/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      builder: (context, child) =>
          MaterialApp(theme: AppTheme.themeData, home: LoginScreen()),
    );
  }
}
