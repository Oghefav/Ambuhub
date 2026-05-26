import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const OnboardingChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.onboardingWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: const BoxDecoration(
                color: AppColours.secondaryBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 14.sp, color: AppColours.primaryColor),
            ),
            SizedBox(width: 3.w),
            Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            
          ],
        ),
      ),
    );
  }
}
