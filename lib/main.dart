import 'package:ambuhub/config/app_theme.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(360, 800),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        initialRoute: AppRoutes.loginScreen,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
