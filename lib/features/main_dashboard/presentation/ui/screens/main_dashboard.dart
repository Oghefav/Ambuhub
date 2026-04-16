import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/dash_board_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [const DashBoardScreen()];
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
