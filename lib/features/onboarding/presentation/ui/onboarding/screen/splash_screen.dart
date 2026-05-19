import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_bloc.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final connectivityState = context.read<ConnectivityBloc>().state;
      if (connectivityState is ConnectivityOnline) {
        context.read<GetServiceCategoriesBloc>().add(const GetServiceCategories());
      } else if (connectivityState is ConnectivityOffline) {
        _showConnectionOfflineSnackBar(context);
      }
    });
  }

  void _navigateToNext() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
    }
  }

  bool _isOffline(BuildContext context) {
    return context.read<ConnectivityBloc>().state is ConnectivityOffline;
  }

  void _clearSnackBars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void _showConnectionOfflineSnackBar(BuildContext context) {
    _clearSnackBars(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        closeIconColor: Colors.white,
        persist: true,
        content: Row(
          children: [
            const Icon(LucideIcons.wifi_off, color: Colors.white),
            SizedBox(width: 10.w),
            const Text(
              'You are currently offline',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showFailedToRetrieveSnackBar(BuildContext context) {
    _clearSnackBars(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to retrieve data'),
      ),
    );
  }

  void _fetchCategoriesIfNeeded(BuildContext context) {
    final serviceState = context.read<GetServiceCategoriesBloc>().state;
    if (serviceState is GetServiceCategoriesError ||
        serviceState is GetServiceCategoriesInitial) {
      context.read<GetServiceCategoriesBloc>().add(const GetServiceCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state is ConnectivityOffline) {
                _showConnectionOfflineSnackBar(context);
                return;
              }
              if (state is ConnectivityOnline) {
                _clearSnackBars(context);
                _fetchCategoriesIfNeeded(context);
              }
            },
          ),
          BlocListener<GetServiceCategoriesBloc, GetServiceCategoriesState>(
            listenWhen: (previous, current) =>
                current is GetServiceCategoriesSuccess ||
                current is GetServiceCategoriesError,
            listener: (context, state) {
              if (state is GetServiceCategoriesSuccess) {
                _clearSnackBars(context);
                _navigateToNext();
                return;
              }
              if (state is GetServiceCategoriesError && !_isOffline(context)) {
                _showFailedToRetrieveSnackBar(context);
              }
            },
          ),
        ],
        child: BlocBuilder<GetServiceCategoriesBloc, GetServiceCategoriesState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(width: 15.h),
                      Text(
                        'AmbuHub',
                        style: Theme.of(context).textTheme.displayMedium!
                            .copyWith(
                              color: AppColours.vividTeal,
                              fontSize: 35.sp,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  if (state is GetServiceCategoriesLoading)
                    const CupertinoActivityIndicator(
                      radius: 14,
                      color: AppColours.blue,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
