import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/auth/presentation/ui/login/screen/login_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/screen/role_screen.dart';
import 'package:ambuhub/features/auth/presentation/ui/sign_up/screen/sign_up_screen.dart';
import 'package:ambuhub/features/availablity/presentation/ui/screens/availability_screen.dart';
import 'package:ambuhub/features/booking/presentation/ui/screen/booking_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/dash_board_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/main_dashboard.dart';
import 'package:ambuhub/features/message/presentation/ui/screen/message_screen.dart';
import 'package:ambuhub/features/profile/presentation/ui/screen/profile_screen.dart';
import 'package:ambuhub/features/setting/presentation/ui/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ambuhub/dependencies_injection.dart';

class AppRoutes {
  static const loginScreen = '/loginScreen';
  static const roleScreen = '/roleScreen';
  static const signUpScreen = '/signUpScreen';
  static const mainDashboard = '/mainDashBoard';
  static const dashBoardScreen = '/dashBoardScreen';
  static const bookingScreen = '/bookingScreen';
  static const availabilityScreen = '/availabilityScreen';
  static const messageScreen = '/messageScreen';
  static const profileScreen = '/profileScreen';
  static const settingScreen = '/settingScreen';
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
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
      case settingScreen:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case messageScreen:
        return MaterialPageRoute(builder: (_) => MessageScreen());
      case availabilityScreen:
        return MaterialPageRoute(builder: (_) => AvailabilityScreen());
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case dashBoardScreen:
        return MaterialPageRoute(builder: (_) => DashBoardScreen());
      case mainDashboard:
        return MaterialPageRoute(builder: (_) => MainDashboard());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
