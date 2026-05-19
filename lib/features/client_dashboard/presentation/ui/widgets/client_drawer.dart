import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/drawer_header.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/drawer_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDrawer extends StatelessWidget {
  const ClientDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, String>(
      builder: (context, selectedPage) {
        final provider = context.read<NavigationCubit>();
        return Drawer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
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
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                  SizedBox(height: 10.h),
                  const AppDrawerHeader(),
                  SizedBox(height: 15.w),
                  DrawerTileBuilder(
                    iconData: LucideIcons.layout_dashboard,
                    onTap: () {
                      provider.setPage('clientDashboard');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.clientDashBoardScreen,
                      );
                    },
                    title: 'Dashboard',
                    isSelected: selectedPage == 'clientDashboard',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.user,
                    onTap: () {
                      provider.setPage('clientProfile');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.clientProfileScreen,
                      );
                    },
                    title: 'Profile',
                    isSelected: selectedPage == 'clientProfile',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.shopping_bag,
                    onTap: () {
                      provider.setPage('order');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.orderScreen,
                      );
                    },
                    title: 'Orders',
                    isSelected: selectedPage == 'order',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.heart,
                    onTap: () {
                      provider.setPage('favorite');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.favoriteScreen,
                      );
                    },
                    title: 'Favorite',
                    isSelected: selectedPage == 'favorite',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.star,
                    onTap: () {
                      provider.setPage('reviews');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.reviewsScreen,
                      );
                    },
                    title: 'Reviews',
                    isSelected: selectedPage == 'reviews',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.share_2,
                    onTap: () {
                      provider.setPage('Referral');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.referralScreen,
                      );
                    },
                    title: 'Referral',
                    isSelected: selectedPage == 'referral',
                  ),
                  DrawerTileBuilder(
                    iconData: LucideIcons.bell,
                    onTap: () {
                      provider.setPage('notifications');
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.notificationScreen,
                      );
                    },
                    title: 'Notification',
                    isSelected: selectedPage == 'notifications',
                  ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
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
                      const Icon(
                        LucideIcons.log_out,
                        color: AppColours.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Sign out',
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: AppColours.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
