import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/auth/presentation/ui/role/widget/navigation_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key,});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 230.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColours.veryDarkBlue, AppColours.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ambuhub',
                      style: textTheme.titleMedium!.copyWith(color: AppColours.white),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColours.darkGrey,
                        border: Border.all(color: AppColours.lightGrey),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Icon(
                          LucideIcons.user_plus,
                          color: AppColours.white,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Sign up to get started',
                      style: textTheme.displayMedium!.copyWith(color: AppColours.white),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Signing up is simple, free, and fast. Join our platform and unlock new possibilities.',
                      style: textTheme.bodyMedium!.copyWith(color: Colors.grey.shade100),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const NavigationSection(),
      ],
    );
  }
}
