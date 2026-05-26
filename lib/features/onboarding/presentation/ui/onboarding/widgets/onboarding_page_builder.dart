import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageBuilder extends StatelessWidget {
  final Widget title;
  final Widget description;
  final String image;
  final Widget firstChip;
  final Widget secondChip;
  final Widget thirdChip;

  const OnboardingPageBuilder({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.firstChip,
    required this.secondChip,
    required this.thirdChip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title,
                  SizedBox(height: 12.h),
                 description,
                  SizedBox(height: 15.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ColoredBox(
                        color: AppColours.onboardingWhite,
                        child: Image.asset(
                          image,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        firstChip,
                      secondChip,
                      thirdChip,
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
