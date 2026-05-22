import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonContainer extends StatelessWidget {
  final VoidCallback? onTap;

  const BackButtonContainer({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColours.hireCyanIce, width: 2.w),
        ),
        child: Text(
          '←  Back',
          style: textTheme.titleSmall?.copyWith(
            color: AppColours.hirePurpleDeep,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
