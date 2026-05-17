import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketplaceTopSection extends StatelessWidget {
  const MarketplaceTopSection({super.key, required this.category});
  final ServiceCategoryEntity category;

  @override
  Widget build(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: category.bannerUrl,
                  progressIndicatorBuilder: (context, url, loadingProgress) {
                    return const Center(
                      child: CupertinoActivityIndicator(color: AppColours.blue),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const SizedBox.shrink();
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(category.name, style: textTheme.titleLarge),
            Text(category.note, style: textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}