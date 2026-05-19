import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/presentation/ui/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryFilterSection extends StatelessWidget {
  final List<ServiceCategoryEntity> categories;
  final ValueNotifier<String> selectedCategory;
  const CategoryFilterSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColours.veryLightVividTeal, width: 1.w),
        ),
        child: SizedBox(
          height: 30.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryTab(
                label: category.name,
                value: category.slug,
                selectedCategory: selectedCategory,
              );
            },
          ),
        ),
      ),
    );
  }
}
