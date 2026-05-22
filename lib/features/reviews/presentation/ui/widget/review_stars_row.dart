import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewStarsRow extends StatelessWidget {
  final int rating;
  final Color filledColor;
  final Color outlineColor;
  final double iconSize;

  const ReviewStarsRow({
    super.key,
    required this.rating,
    required this.filledColor,
    required this.outlineColor,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;
        return Icon(
          isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
          color: isFilled ? filledColor : outlineColor,
          size: iconSize.sp,
        );
      }),
    );
  }
}
