import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/custom_divider.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_header.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              AppDrawerHeader(),
              SizedBox(height: 15.w),
              DrawerTileBuilder(
                iconData: LucideIcons.layout_dashboard,
                onTap: () {
                  context.read<NavigationCubit>().setPage(0);
                  Navigator.pop(context);
                },
                title: 'Dashboard',
                isSelected: 0 == currentIndex,
                index: 0,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.package_plus,
                onTap: () {
                  context.read<NavigationCubit>().setPage(1);
                  Navigator.pop(context);
                },
                title: 'Add service',
                isSelected: 1 == currentIndex,
                index: 1,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.list,
                onTap: () {
                  context.read<NavigationCubit>().setPage(2);
                  Navigator.pop(context);
                },
                title: 'My listings',
                isSelected: 2 == currentIndex,
                index: 2,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.calendar,
                onTap: () {
                  context.read<NavigationCubit>().setPage(3);
                  Navigator.pop(context);
                },
                title: 'Bookings',
                isSelected: 3 == currentIndex,
                index: 3,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.calendar_clock,
                onTap: () {
                  context.read<NavigationCubit>().setPage(4);
                  Navigator.pop(context);
                },
                title: 'Availability',
                isSelected: 4 == currentIndex,
                index: 4,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.message_square,
                onTap: () {
                  context.read<NavigationCubit>().setPage(5);
                  Navigator.pop(context);
                },
                title: 'Messages',
                isSelected: 5 == currentIndex,
                index: 5,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.building_2,
                onTap: () {
                  context.read<NavigationCubit>().setPage(6);
                  Navigator.pop(context);
                },
                title: 'Business profile',
                isSelected: 6 == currentIndex,
                index: 6,
              ),
              DrawerTileBuilder(
                iconData: LucideIcons.settings,
                onTap: () {
                  context.read<NavigationCubit>().setPage(7);
                  Navigator.pop(context);
                },
                title: 'Settings',
                isSelected: 7 == currentIndex,
                index: 7,
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
                  Text(
                    'Sign out',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
