import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/dependencies_injection.dart';
import 'package:ambuhub/features/auth/presentation/ui/widgets/error_message_container.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_bloc.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_state.dart';
import 'package:ambuhub/features/booking/presentation/ui/widgets/provider_bookings_body.dart';
import 'package:ambuhub/features/booking/presentation/ui/widgets/provider_bookings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreen extends HookWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingBloc>()..add(const GetHireBookings()),
      child: const _BookingScreenContent(),
    );
  }
}

class _BookingScreenContent extends HookWidget {
  const _BookingScreenContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ProviderAppScaffold(
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const CustomAppbar(),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 24.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProviderBookingsHeader(),
                      if (state.isLoading && !state.hasLoaded) ...[
                        SizedBox(height: 15.h),
                        Text(
                          'Loading your bookings...',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                      if (state.hasLoaded && !state.isLoading) ...[
                        if (state.errorMessage != null &&
                            state.errorMessage!.isNotEmpty) ...[
                          SizedBox(height: 15.h),
                          ErrorMessageContainer(
                            errorMessage: state.errorMessage!,
                          ),
                        ] else ...[
                          SizedBox(height: 20.h),
                          ProviderBookingsBody(
                            selectedTab: state.selectedTab,
                            hireBookings: state.hireBookings,
                            onTabSelected: (tab) {
                              context.read<BookingBloc>().add(
                                SelectProviderBookingTab(tab),
                              );
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
