import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/screens/dash_board_screen.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/custom_divider.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_header.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainDashboard extends HookWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);

    final List<Widget> pages = [const DashBoardScreen()];
    return Scaffold(
      drawerScrimColor: AppColours.teal.withAlpha(80),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            AppDrawerHeader(),
            SizedBox(height: 15.w),
            DrawerTileBuilder(
              iconData: LucideIcons.layout_dashboard,
              onTap: () {
                selectedIndex.value = 0;
                Navigator.pop(context);
              },
              title: 'Dashboard',
              isSelected: 0 == selectedIndex.value,
              index: 0,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.package_plus,
              onTap: () {
                selectedIndex.value = 3;
                Navigator.pop(context);
              },
              title: 'Add service',
              isSelected: 1 == selectedIndex.value,
              index: 1,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.list,
              onTap: () {
                selectedIndex.value = 1;
                Navigator.pop(context);
              },
              title: 'My listings',
              isSelected: 1 == selectedIndex,
              index: 1,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.calendar,
              onTap: () {
                selectedIndex.value = 2;
                Navigator.pop(context);
              },
              title: 'Bookings',
              isSelected: 2 == selectedIndex.value,
              index: 2,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.calendar_clock,
              onTap: () {
                selectedIndex.value = 3;
                Navigator.pop(context);
              },
              title: 'Availability',
              isSelected: 3 == selectedIndex.value,
              index: 3,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.message_square,
              onTap: () {
                selectedIndex.value = 4;
                Navigator.pop(context);
              },
              title: 'Messages',
              isSelected: 4 == selectedIndex.value,
              index: 4,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.building_2,
              onTap: () {
                selectedIndex.value = 5;
                Navigator.pop(context);
              },
              title: 'Business profile',
              isSelected: 5 == selectedIndex.value,
              index: 5,
            ),
            DrawerTileBuilder(
              iconData: LucideIcons.settings,
              onTap: () {
                selectedIndex.value = 6;
                Navigator.pop(context);
              },
              title: 'Settings',
              isSelected: 6 == selectedIndex.value,
              index: 6,
            ),
            SizedBox(height: 290.h),
            CustomDivider(),
            Row(
              children: [
                SizedBox(width: 10.w),
                IconButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.loginScreen,
                  ),
                  icon: Icon(LucideIcons.log_out),
                ),
                Text('Sign out', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ],
        ),
      ),
      body: IndexedStack(index: selectedIndex.value, children: pages),
    );
  }
}
