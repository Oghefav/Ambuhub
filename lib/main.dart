import 'package:ambuhub/config/app_theme.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/dependencies_injection.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO 1: Validate country and number if needed
// TODO 1: make dashboard persistis use token is token is the active kjkjk;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependeciesInjection();
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
      ensureScreenSize: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: ((context) => sl<AuthBloc>())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          initialRoute: AppRoutes.loginScreen,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
