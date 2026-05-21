import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_gradient_border_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_non_gradient_container.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireOfficeLocationCard extends StatelessWidget {
  final ServiceEntity service;

  const HireOfficeLocationCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return HireGradientBorderContainer(
      borderColor: AppColours.hireLavenderWash,
      gradientColors: const [
        AppColours.hireLavenderWash,
        AppColours.white,
        AppColours.white,
        AppColours.hireLavenderWash,
      ],
      
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0.0,0.2, 0.9, 1.0],
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8.w,
              children: [
                IconNonGradientContainer(
                  icon: LucideIcons.map_pin,
                  color: AppColours.hireLavenderWash,
                  iconColor: AppColours.hireIndigo,
                  size: 13.sp,
                ),
                Text(
                  'OFFICE LOCATION',
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 11.sp,
                    color: AppColours.darkBrandBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text('Country', style: textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              service.country ?? 'No Country provided',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 10.h),
            Text('State / province', style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade500),
            ),
            Text(
              service.stateProvinceName ?? 'No state provided',
              style: textTheme.bodySmall!.copyWith(color: AppColours.grey),
            ),
            SizedBox(height: 10.h),
            Text('Address', style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade500),
            ),
            Text(
              service.officeAddress ?? 'No address provided',
              style: textTheme.bodySmall!.copyWith(color: AppColours.grey),
            ),
          ],
        ),
      ),
    );
  }
}
