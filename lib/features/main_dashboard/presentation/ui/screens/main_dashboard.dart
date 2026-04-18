import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/availablity/presentation/ui/screens/availability_screen.dart';
import 'package:ambuhub/features/booking/presentation/ui/screen/booking_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/dash_board_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer.dart';
import 'package:ambuhub/features/message/presentation/ui/screen/message_screen.dart';
import 'package:ambuhub/features/profile/presentation/ui/screen/profile_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/screens/add_service_screen.dart';
import 'package:ambuhub/features/services/presentation/ui/screens/listings_screen.dart';
import 'package:ambuhub/features/setting/presentation/ui/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashBoardScreen(),
      AddServiceScreen(),
      ListingsScreen(),
      BookingScreen(),
      AvailabilityScreen(),
      MessageScreen(),
      ProfileScreen(),
      SettingScreen(),
    ];
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          drawerScrimColor: AppColours.teal.withAlpha(80),
          drawer: AppDrawer(),
          body: IndexedStack(index: currentIndex, children: pages),
        );
      },
    );
  }
}
