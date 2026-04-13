import 'package:ambuhub/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/screens/role_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const loginScreen = '/loginScreen';
  static const roleScreen = '/roleScreen';
  static const signUpScreen = '/signUpScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case roleScreen:
        return MaterialPageRoute(builder: (_) => RoleScreen());

      case signUpScreen:
        final role = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SignUpScreen(role: role));

      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
