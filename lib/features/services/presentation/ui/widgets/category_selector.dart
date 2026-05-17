import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatelessWidget {
  final String categoryName;
  final bool isSelected;

  const CategorySelector({
    super.key,
    required this.categoryName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: isSelected ? AppColours.vividTeal : AppColours.veryLightVividTeal,
      //   gradient: isSelected
      //       ? const LinearGradient(
      //           colors: [
      //             AppColours.brightBlue,
      //             AppColours.cyanBlue,
      //           ],
      //         )
      //       : null,
      ),
      child: Text(
        categoryName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isSelected ? AppColours.white : Colors.black,
        ),
      ),
    );
  }
}
