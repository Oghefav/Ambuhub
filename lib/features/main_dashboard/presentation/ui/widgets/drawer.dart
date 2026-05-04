import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_header.dart';
import 'package:ambuhub/features/main_dashboard/presentation/ui/widgets/drawer_tile_builder.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, String>(
      builder: (context, selectedPage) {
        final provider = context.read<NavigationCubit>();
        return Drawer(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColours.penBlue, width: 2),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColours.penBlue,
                    AppColours.veryDarkBlue,
                    AppColours.veryDarkBlue,
                  ],
                  stops: [0.0, 0.2, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  AppDrawerHeader(),
                  SizedBox(height: 15.w),
                  DrawerTileBuilder(
                    iconData: LucideIcons.layout_dashboard,
                    onTap: () {
                      provider.setPage('dashboard');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.dashBoardScreen,
                      );
                    },
                    title: 'Dashboard',
                    isSelected: selectedPage == 'dashboard',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.package_plus,
                    onTap: () {
                      provider.setPage('addService');
                      BlocProvider.of<AddServiceBloc>(
                        context,
                      ).add(AddServiceReset());
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.addServiceScreen,
                      );
                    },
                    title: 'Add service',
                    isSelected: selectedPage == 'addService',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.list,
                    onTap: () {
                      provider.setPage('listings');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.listingsScreen,
                      );
                    },
                    title: 'My listings',
                    isSelected: selectedPage == 'listings',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.calendar,
                    onTap: () {
                      provider.setPage('bookings');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.bookingScreen,
                      );
                    },
                    title: 'Bookings',
                    isSelected: selectedPage == 'bookings',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.calendar_clock,
                    onTap: () {
                      provider.setPage('availability');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.availabilityScreen,
                      );
                    },
                    title: 'Availability',
                    isSelected: selectedPage == 'availability',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.message_square,
                    onTap: () {
                      provider.setPage('messages');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.messageScreen,
                      );
                    },
                    title: 'Messages',
                    isSelected: selectedPage == 'messages',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.building_2,
                    onTap: () {
                      provider.setPage('businessProfile');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.profileScreen,
                      );
                    },
                    title: 'Business profile',
                    isSelected: selectedPage == 'businessProfile',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.settings,
                    onTap: () {
                      provider.setPage('settings');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.settingScreen,
                      );
                    },
                    title: 'Settings',
                    isSelected: selectedPage == 'settings',
                  ),
                  SizedBox(height: 290.h),
                  Divider(color: AppColours.penBlue, height: 2.h),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.loginScreen,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20.w),

                        Icon(LucideIcons.log_out, color: AppColours.white),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign out',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColours.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
