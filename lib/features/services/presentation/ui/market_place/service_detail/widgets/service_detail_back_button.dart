import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailBackButton extends StatelessWidget {
  final String backLabel;
  final VoidCallback? onBack;

  static const Color _borderColor = AppColours.hireCyanIce;

  const ServiceDetailBackButton({
    super.key,
    required this.backLabel,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onBack ?? () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: _borderColor),
        ),
        child: Text(
          '← $backLabel',
          style: textTheme.titleSmall?.copyWith(
            color: AppColours.darkVividTeal,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
