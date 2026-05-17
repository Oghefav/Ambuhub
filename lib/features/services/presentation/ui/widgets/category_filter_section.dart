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
        padding: EdgeInsets.all(5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
         border: Border.all(color: AppColours.verylightTeal, width: 1.w),
        ),
        child: Wrap(
          spacing: 10.w,
          direction: Axis.horizontal,
          children: List.generate(
            categories.length,
            (index) => CategoryTab(
              label: categories[index].name,
              value: categories[index].slug,
              selectedCategory: selectedCategory,
            ),
          ),
        ),
      ),
    );
  }
}
