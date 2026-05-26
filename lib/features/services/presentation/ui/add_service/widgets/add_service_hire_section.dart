import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_form_styles.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_pricing_period.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_time_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/add_service_form_section.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/widgets/drop_down_form_field_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceHireSection extends HookWidget {
  final ValueNotifier<String> selectedPricingPeriod;
  final ValueNotifier<Set<int>> selectedReturnDays;
  final ValueNotifier<TimeOfDay> returnFrom;
  final ValueNotifier<TimeOfDay> returnUntil;
  final ValueNotifier<String?> returnTimeError;
  final TextEditingController returnFromController;
  final TextEditingController returnUntilController;
  final VoidCallback onChanged;

  const AddServiceHireSection({
    super.key,
    required this.selectedPricingPeriod,
    required this.selectedReturnDays,
    required this.returnFrom,
    required this.returnUntil,
    required this.returnTimeError,
    required this.returnFromController,
    required this.returnUntilController,
    required this.onChanged,
  });

  static const List<(int weekday, String shortLabel)> _weekdays = [
    (7, 'Sun'),
    (1, 'Mon'),
    (2, 'Tue'),
    (3, 'Wed'),
    (4, 'Thu'),
    (5, 'Fri'),
    (6, 'Sat'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.h,
      children: [
        DropDownFormFieldBuilder(
          value: selectedPricingPeriod.value,
          isEnabled: true,
          hintText: 'Select period',
          items: kPricingPeriodMenuItems,
          title: 'Pricing period',
          placeHolder: kPricingPeriodPlaceholder,
          onChanged: (value) {
            selectedPricingPeriod.value =
                value ?? kPricingPeriodPlaceholder;
            onChanged();
          },
        ),
        Text(
          'How the hire price applies (e.g. per hour, per day).',
          style: textTheme.bodySmall?.copyWith(
            color: AppColours.grey,
            fontSize: 11.sp,
          ),
        ),
        AddServiceFormSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              Text(
                'Return schedule',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColours.darkVividTeal,
                ),
              ),
              Text(
                'Return days (WAT)',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                'When customers may return hired items to your office',
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  color: AppColours.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedReturnDays.value = {1, 2, 3, 4, 5};
                  onChanged();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(240, 246, 255, 1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColours.veryLightVividTeal),
                  ),
                  child: Text(
                    'Weekdays (Mon–Fri)',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColours.vividTeal,
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<Set<int>>(
                valueListenable: selectedReturnDays,
                builder: (context, days, _) {
                  return Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _weekdays.map((entry) {
                      final selected = days.contains(entry.$1);
                      return GestureDetector(
                        onTap: () {
                          final next = Set<int>.from(days);
                          if (selected) {
                            next.remove(entry.$1);
                          } else {
                            next.add(entry.$1);
                          }
                          selectedReturnDays.value = next;
                          onChanged();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColours.blue
                                : AppColours.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: selected
                                  ? AppColours.blue
                                  : AppColours.veryLightGrey,
                            ),
                          ),
                          child: Text(
                            entry.$2,
                            style: textTheme.bodySmall?.copyWith(
                              color: selected
                                  ? AppColours.white
                                  : AppColours.darkVividTeal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              _ReturnTimeField(
                title: 'Return from',
                controller: returnFromController,
                initial: returnFrom,
                onPicked: (time) {
                  returnFrom.value = time;
                  returnFromController.text = formatTimeOfDayDisplay(time);
                  onChanged();
                },
              ),
              _ReturnTimeField(
                title: 'Return until',
                controller: returnUntilController,
                initial: returnUntil,
                onPicked: (time) {
                  returnUntil.value = time;
                  returnUntilController.text = formatTimeOfDayDisplay(time);
                  onChanged();
                },
              ),
              ValueListenableBuilder<String?>(
                valueListenable: returnTimeError,
                builder: (context, error, _) {
                  if (error == null) return const SizedBox.shrink();
                  return Text(
                    error,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColours.deepRed,
                      fontSize: 11.sp,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReturnTimeField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final ValueNotifier<TimeOfDay> initial;
  final ValueChanged<TimeOfDay> onPicked;

  const _ReturnTimeField({
    required this.title,
    required this.controller,
    required this.initial,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          readOnly: true,
          controller: controller,
          style: AddServiceFormStyles.hint(Theme.of(context).textTheme),
          decoration: InputDecoration(
            hintText: '09:00 AM',
            hintStyle: AddServiceFormStyles.hint(Theme.of(context).textTheme),
            suffixIcon: IconButton(
              onPressed: () async {
                final picked = await pickReturnTime(
                  context,
                  initial: initial.value,
                );
                if (picked != null) onPicked(picked);
              },
              icon: Icon(LucideIcons.clock, size: 18.sp),
            ),
          ),
        ),
      ],
    );
  }
}
