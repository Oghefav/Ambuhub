import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_gradient_border_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_non_gradient_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireReturnWindowCard extends StatelessWidget {
  final ServiceEntity service;

  const HireReturnWindowCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return HireGradientBorderContainer(
      borderColor: AppColours.hireButtercream,
      gradientColors:  [
        AppColours.hireLemonCream,
         Color.lerp(AppColours.hireLemonCream, Colors.white, 0.9)!,
        AppColours.hireParchment,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.1, 1.0],
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8.w,
              children: [
                IconNonGradientContainer(
                  icon: LucideIcons.calendar_clock,
                  color: AppColours.hireButtercream,
                  iconColor: AppColours.hireSienna,
                  size: 15.sp,
                ),
                Text(
                  'RETURN SCHEDULE (WAT)',
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 11.sp,
                    color: AppColours.hireSienna,
                  ),
                ),
              ],
            ),
            _ReturnScheduleChip(service: service),
            Text(
              'Your return date and time must fall within this window (West Africa Time).',
              style: textTheme.bodySmall!.copyWith(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReturnScheduleChip extends StatelessWidget {
  final ServiceEntity service;

  const _ReturnScheduleChip({required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color.lerp(AppColours.hireLemonCream, Colors.white, 0.4)!,
            blurRadius: 10.r,
          ),
        ],
        border: Border.all(color: AppColours.hireButtercream, width: 1.5.w),
        color: Color.lerp(AppColours.hireLemonCream, Colors.white, 0.5)!,
      ),
      child: Text(
        '${service.hireReturnWindow?.formattedDaysOfWeek} '
        '${service.hireReturnWindow?.timeStart} AM - '
        '${service.hireReturnWindow?.timeEnd} PM (WAT)',
        style: textTheme.titleSmall?.copyWith(
          color: AppColours.hireSienna,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
