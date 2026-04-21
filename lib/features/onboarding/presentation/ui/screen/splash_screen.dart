import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_bloc.dart';
import 'package:ambuhub/features/onboarding/presentation/blocs/connectivity_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_cat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      context.read<GetServiceCatBloc>().add(GetServiceCategories());
    }
  }

  void _navigateToNext() async {
    // if (_navigated) return;
    // _navigated = true;
    await Future.delayed(const Duration(seconds: 4));

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
            final serviceState = context.read<GetServiceCatBloc>().state;
            if (serviceState is GetServiceCatFailure ||
                serviceState is GetServiceCatInitial) {
              context.read<GetServiceCatBloc>().add(GetServiceCategories());
            }
          }
        },

        child: BlocConsumer<GetServiceCatBloc, GetServiceCatState>(
          listener: (context, state) {
            if (state is GetServiceCatSuccess) {
              _navigateToNext();
            } else if (state is GetServiceCatFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? 'Something went wrong'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
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
                  if (state is GetServiceCatLoading)
                    const CircularProgressIndicator()
                  else if (state is GetServiceCatFailure)
                    Text(
                      state.error!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
