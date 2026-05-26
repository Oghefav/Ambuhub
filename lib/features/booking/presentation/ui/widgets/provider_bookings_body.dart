import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:ambuhub/features/booking/presentation/ui/widgets/booking_type_selector_row.dart';
import 'package:ambuhub/features/booking/presentation/ui/widgets/hire_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Tab row plus hire list or empty placeholder for the active tab.
class ProviderBookingsBody extends StatelessWidget {
  final ProviderBookingTab selectedTab;
  final List<HireBookingEntity> hireBookings;
  final ValueChanged<ProviderBookingTab> onTabSelected;

  const ProviderBookingsBody({
    super.key,
    required this.selectedTab,
    required this.hireBookings,
    required this.onTabSelected,
  });

  static const String _hireEmptyMessage =
      'No hire bookings yet. When clients hire your listings, they will appear here.';

  static const String _personnelEmptyMessage =
      'No personnel bookings yet. When clients book your listings, they will appear here.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BookingTypeSelectorRow(
          selectedTab: selectedTab,
          onTabSelected: onTabSelected,
        ),
        SizedBox(height: 20.h),
        if (selectedTab == ProviderBookingTab.personnel)
          _BookingsEmptyPlaceholder(message: _personnelEmptyMessage)
        else if (hireBookings.isEmpty)
          const _BookingsEmptyPlaceholder(message: _hireEmptyMessage)
        else
          ...hireBookings.map((booking) => HireBookingCard(booking: booking)),
      ],
    );
  }
}

class _BookingsEmptyPlaceholder extends StatelessWidget {
  final String message;

  const _BookingsEmptyPlaceholder({required this.message});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DottedBorderContainer(
      borderColor: AppColours.veryLightGrey,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 11.sp,
              color: AppColours.grey,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}
