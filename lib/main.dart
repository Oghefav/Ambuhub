import 'package:ambuhub/config/app_theme.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/dependencies_injection.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/conectivity_event.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_services/get_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service/update_service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO 1: and number if needed
// TODO 1: make dashboard persistis use token is token is the active kjkjk;
void main() async {
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); 
  await dependeciesInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _precached = false; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_precached) {
      _precached = true;
      Future.wait([
        precacheImage(const AssetImage('assets/images/logo.png'), context),
        precacheImage(const AssetImage('assets/images/equipment.webp'), context),
        precacheImage(const AssetImage('assets/images/personnel.webp'), context),
        precacheImage(const AssetImage('assets/images/transport.webp'), context),
        precacheImage(const AssetImage('assets/images/servicing.webp'), context),
      ]).then((value) {
        FlutterNativeSplash.remove();
      });
    }
  }
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
          BlocProvider<NavigationCubit>(
            create: ((context) => NavigationCubit()),
          ),
          BlocProvider<GetServicesBloc>(
            create: ((context) => sl<GetServicesBloc>()),
          ),
          BlocProvider<AddServiceBloc>(
            create: ((context) => sl<AddServiceBloc>()),
          ),
          BlocProvider<GetServiceCatBloc>(
            create: ((context) => sl<GetServiceCatBloc>()),
          ),
          BlocProvider<UpdateServiceBloc>(
            create: ((context) => sl<UpdateServiceBloc>()),
          ),
          BlocProvider(
            create: (_) =>
                ConnectivityBloc()..add(ConnectivityStartMonitoring()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
