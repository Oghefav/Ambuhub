import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/booking/core/util/hire_booking_format.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireBookingCard extends StatelessWidget {
  final HireBookingEntity booking;

  const HireBookingCard({super.key, required this.booking});

  static const Color _activeBadgeBg = Color.fromRGBO(207, 250, 229, 1);
  static const Color _endedBadgeBg = Color.fromRGBO(242, 246, 250, 1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isActive = booking.isActive;
    final startLine = formatHireBookingStart(booking);
    final endLine = formatHireBookingEnd(booking);
    final periodLine = formatHireBookingPeriodSummary(booking);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(13.r),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColours.veryLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  booking.listingTitle,
                  style: textTheme.titleSmall?.copyWith(fontSize: 13.sp),
                ),
              ),
              SizedBox(width: 12.w),
              _StatusBadge(isActive: isActive),
            ],
          ),
          // SizedBox(height: 10.h),
          Text(
            booking.customer.displayName,
            style: textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Email: ${booking.customer.email}',
            style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Phone: ${booking.customer.phone}',
            style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 14.h),
          Divider(color: AppColours.veryLightGrey, height: 1),
          SizedBox(height: 12.h),
          if (startLine != null) ...[
            Text(startLine, style: textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
            SizedBox(height: 6.h),
          ],
          if (endLine != null) ...[
            Text(endLine, style: textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
            SizedBox(height: 6.h),
          ],
          Text(periodLine, style: textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
          SizedBox(height: 8.h),
          Text(
            formatCurrency(booking.lineTotalNgn),
            style: textTheme.titleSmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            formatHireBookingReceiptLine(booking),
            style: textTheme.bodySmall?.copyWith(
              fontSize: 11.sp,
              color: AppColours.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;

  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive ? HireBookingCard._activeBadgeBg : HireBookingCard._endedBadgeBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isActive ? 'Active' : 'Ended',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColours.hireForest : AppColours.grey,
            ),
      ),
    );
  }
}
