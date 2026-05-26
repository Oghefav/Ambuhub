import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/add_service/add_service_event.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_bloc.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_event.dart';
import 'package:ambuhub/features/provider_dashboard/presentation/bloc/provider_dashboard_state.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/activity_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/card_builder.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/performance_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/search_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/ui/widgets/small_gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderDashBoardScreen extends HookWidget {
  ProviderDashBoardScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ProviderAppScaffold(
      body: RefreshIndicator(
        color: AppColours.vividTeal,
        onRefresh: () async {
          final bloc = context.read<ProviderDashboardBloc>();
          bloc.add(const LoadProviderDashboard(forceRefresh: true));
          while (bloc.state.isWalletLoading || bloc.state.isSalesLoading) {
            await Future<void>.delayed(const Duration(milliseconds: 50));
          }
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const CustomAppbar(),
            SliverList(
            delegate: SliverChildListDelegate([
              Card(
                margin: EdgeInsets.all(15.r),
                elevation: 0,
                color: AppColours.white,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DashBoard',
                        style: textTheme.displayLarge,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Track your provider performance, listings, and activity from one place.',
                        style: textTheme.bodyMedium,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<NavigationCubit>()
                                  .setPage('provider_notifications');
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.providerNotificationsScreen,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColours.veryLightGrey,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Icon(
                                  LucideIcons.bell,
                                  color: AppColours.grey,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SmallGradientContainer(
                              iconData: LucideIcons.upload,
                              title: 'Upload listing',
                              onTap: () {
                                context
                                    .read<NavigationCubit>()
                                    .setPage('addService');
                                context
                                    .read<AddServiceBloc>()
                                    .add(const AddServiceReset());
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.addServiceScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      SearchContainer(searchController: searchController),
                      SizedBox(height: 15.h),
                      BlocBuilder<ProviderDashboardBloc, ProviderDashboardState>(
                        builder: (context, dashboardState) {
                          return CardBuilder(
                            cardNumber: 1,
                            firstText: 'Wallet Balance',
                            secondText: 'Available balance',
                            isWalletBalance: true,
                            isWalletLoading: dashboardState.isWalletLoading,
                            amountValue:
                                dashboardState.walletBalanceNgn.toString(),
                          );
                        },
                      ),
                      const CardBuilder(
                        cardNumber: 2,
                        firstText: 'Active Listings',
                        numberValue: 18,
                        secondText: '+3 this week',
                      ),
                      const CardBuilder(
                        cardNumber: 3,
                        firstText: 'Open bookings',
                        secondText: '+2 this week',
                        numberValue: 7,
                      ),
                      const CardBuilder(
                        cardNumber: 4,
                        firstText: 'Unread notifications',
                        numberValue: 12,
                        secondText: '4 urgent',
                      ),
                      SizedBox(height: 15.h),
                      const PerformanceContainer(),
                      SizedBox(height: 15.h),
                      const ActivityContainer(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          ],
        ),
      ),
    );
  }
}
