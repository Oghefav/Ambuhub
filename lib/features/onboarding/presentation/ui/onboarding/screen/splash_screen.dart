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
  // bool _navigated = false;

  @override
  void initState() {
    super.initState();

    final connectivityState = context.read<ConnectivityBloc>().state;
    if (connectivityState is ConnectivityOnline) {
      context.read<GetServiceCategoriesBloc>().add(const GetServiceCategories());
    }
  }

  void _navigateToNext() async {
    // if (_navigated) return;
    // _navigated = true;

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: BlocListener<ConnectivityBloc, ConnectivityState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is ConnectivityOnline) {
            print('ConnectivityOnline');
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            final serviceState = context.read<GetServiceCategoriesBloc>().state;
            if (serviceState is GetServiceCategoriesError ||
                serviceState is GetServiceCategoriesInitial) {
              context.read<GetServiceCategoriesBloc>().add(
                const GetServiceCategories(),
              );
            }
          }
          if (state is ConnectivityOffline) {
            print('ConnectivityOffline');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                closeIconColor: Colors.white,

                duration: const Duration(seconds: 5),
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
        },

        child: BlocConsumer<GetServiceCategoriesBloc, GetServiceCategoriesState>(
          listener: (context, state) async {
            if (state is GetServiceCategoriesSuccess) {
              print('is is successfully fetched');
              _navigateToNext();
            }
          },
          builder: (context, state) {
            print('state: $state');
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
