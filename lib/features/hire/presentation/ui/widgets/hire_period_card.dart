import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_select_date.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_text_gradient_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/utils.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HirePeriodCard extends StatelessWidget {
  final ServiceEntity service;
  final ValueNotifier<DateTime?> selectedStartDate;
  final ValueNotifier<DateTime?> selectedEndDate;
  final ValueNotifier<String?> errorText;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String billingPeriod;
  final ValueNotifier<int?> billingUnits;

  const HirePeriodCard({
    super.key,
    required this.service,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.errorText,
    required this.startDateController,
    required this.endDateController,
    required this.billingPeriod,
    required this.billingUnits,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: selectedEndDate,
      builder: (context, endDate, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: errorText,
          builder: (context, error, _) =>
              _buildCard(context, endDate, error),
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context,
    DateTime? endDate,
    String? error,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return ShadowedContainer(
      shadowColor: Color.lerp(AppColours.hireCyanTeal, Colors.white, 0.5)!,
      borderColor: AppColours.hireCyanTeal,
      topGradientColors: const [
        AppColours.hireCyanTeal,
        AppColours.hireCyanSky,
      ],
      bodyGradientColors: [
        Color.lerp(AppColours.hireCyanTeal, Colors.white, 0.5)!,
        Color.lerp(AppColours.hireCyanTeal, Colors.white, 0.9)!,
        AppColours.white,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      bodyStops: const [0.0, 0.1, 1.0],
      topStops: const [0.1, 1.0],
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10.w,
              children: [
                IconGradientContainer(
                  icon: LucideIcons.calendar_clock,
                  gradientStops: const [0.0, 1.0],
                  colors: const [
                    AppColours.hireCyanTeal,
                    AppColours.hireCyanSky,
                  ],
                  size: 15.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hire period',
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColours.hirePurpleDeep,
                      ),
                    ),
                    Text(
                      'Start and return within the window',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text('Start date', style: textTheme.bodySmall!.copyWith(fontSize: 10.sp)),
            SizedBox(height: 5.h),
            TextFormField(
              readOnly: true,
              controller: startDateController,
              keyboardType: TextInputType.datetime,
              onChanged: (_) => hireOnChange(
                service,
                errorText,
                selectedStartDate,
                selectedEndDate,
              ),
              style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                suffixIcon: IconButton(
                  onPressed: () async {
                    await hireSelectDate(
                      context,
                      startDateController,
                      selectedStartDate,
                    );
                    hireOnChange(
                      service,
                      errorText,
                      selectedStartDate,
                      selectedEndDate,
                    );
                  },
                  icon: Icon(LucideIcons.calendar, size: 15.sp),
                ),
                
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColours.hireCyanTeal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColours.hireCyanTeal),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColours.hireCyanTeal),
              ),
              ),
            ),
            SizedBox(height: 10.h),
            Text('Return by (date)', style: textTheme.bodySmall!.copyWith(fontSize: 10.sp)),
            SizedBox(height: 5.h),
            TextFormField(
              readOnly: true,
              controller: endDateController,
              keyboardType: TextInputType.datetime,
              onChanged: (_) => hireOnChange(
                service,
                errorText,
                selectedStartDate,
                selectedEndDate,
              ),
              style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black, 
              fontWeight: FontWeight.w500,
            ),
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  onPressed: () async {
                    await hireSelectDate(
                      context,
                      endDateController,
                      selectedEndDate,
                    );
                    hireOnChange(
                      service,
                      errorText,
                      selectedStartDate,
                      selectedEndDate,
                    );
                  },
                  icon: Icon(LucideIcons.calendar, size: 15.sp),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColours.hireCyanTeal,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColours.hireCyanTeal),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColours.hireCyanTeal,
                ),
              ),
              ),
            ),
            Text(
              'Item must be returned by ${service.hireReturnWindow?.timeEnd} on the selected day.',
              style: textTheme.bodySmall?.copyWith(fontSize: 8.sp),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Return deadline: ', style: textTheme.titleSmall?.copyWith(fontSize: 10.sp)),
                  TextSpan(
                    text: '${formatDateTimeLong(endDate)} ${service.hireReturnWindow?.timeEnd}',
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColours.selectedBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            if (error != null)
              Text(
                error,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColours.deepRed,
                  fontSize: 10.sp,
                ),
              )
            else
              HireTextGradientContainer(
                text1Widget: RichText(text: 
                 TextSpan(children: [
                  TextSpan(text: ' Billing units (${billingPeriod.toTitleCase()}):', style: textTheme.bodySmall?.copyWith(color: AppColours.hireForest, fontSize: 11.sp)),
                  TextSpan(text: ' ${billingUnits.value ?? 'pricing period was not set'}', style: textTheme.titleSmall?.copyWith(color: AppColours.hirePurpleDeep, fontSize: 11.sp)),
                  ]),
                ),
                color: Color.lerp(AppColours.hireCyanTeal, Colors.white, 0.8)!,
                textColor: AppColours.hireForest,
              ),
          ],
        ),
      
    );
  }
}
