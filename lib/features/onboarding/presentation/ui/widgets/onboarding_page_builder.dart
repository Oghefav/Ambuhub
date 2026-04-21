import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/submit_button.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageBuilder extends StatelessWidget {
  final ServiceCategoryEntity category;
  const OnboardingPageBuilder({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            color: AppColours.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(color: AppColours.veryLightVividTeal),
            ),
            child: Column(
              children: [
                Image.network(category.bannerUrl),
                SizedBox(height: 25.h),
                Text(category.name, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 15.h),
                Text(category.note, style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 10.h),
                GestureDetector(
                  child: Text(
                    'Learn more',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColours.blue),
                  ),
                ),
                
                
              ],
            ),
          ),
          SubmitButton(buttonText: 'Next'),
        ],
      ),
    );
  }
}
