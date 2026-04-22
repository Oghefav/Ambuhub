import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageBuilder extends StatelessWidget {
  final ServiceCategoryEntity category;
  const OnboardingPageBuilder({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: CachedNetworkImage(
                imageUrl: category.thumbnailUrl,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholder: (context, url) => const SizedBox.shrink(),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 15.h),
                Text(
                  category.note,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                SizedBox(height: 10.h),
                GestureDetector(
                  child: Text(
                    'Learn more',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColours.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
