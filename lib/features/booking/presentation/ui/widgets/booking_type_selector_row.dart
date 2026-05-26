import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTypeSelectorRow extends StatelessWidget {
  final ProviderBookingTab selectedTab;
  final ValueChanged<ProviderBookingTab> onTabSelected;

  const BookingTypeSelectorRow({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BookingTypeChip(
          label: 'Hire',
          isSelected: selectedTab == ProviderBookingTab.hire,
          onTap: () => onTabSelected(ProviderBookingTab.hire),
        ),
        SizedBox(width: 10.w),
        _BookingTypeChip(
          label: 'Personnel bookings',
          isSelected: selectedTab == ProviderBookingTab.personnel,
          onTap: () => onTabSelected(ProviderBookingTab.personnel),
        ),
      ],
    );
  }
}

class _BookingTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BookingTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: isSelected ? AppColours.blue : Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Text(
            label,
            style: textTheme.titleSmall?.copyWith(
              color: isSelected ? AppColours.white : AppColours.grey,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
