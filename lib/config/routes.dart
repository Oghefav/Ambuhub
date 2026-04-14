import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/screen/login_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/screen/role_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ambuhub/dependencies_injection.dart';

class AppRoutes {
  static const loginScreen = '/loginScreen';
  static const roleScreen = '/roleScreen';
  static const signUpScreen = '/signUpScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
 
        );

      case roleScreen:
        return MaterialPageRoute(builder: (_) => RoleScreen());

      case signUpScreen:
        final role = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>(
            create: ((context) => sl<AuthBloc>()),
            child: SignUpScreen(role: role),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
