import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared label / hint styles for the add-service form.
class AddServiceFormStyles {
  static TextStyle label(TextTheme textTheme) => textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      );

  static TextStyle hint(TextTheme textTheme) => textTheme.bodySmall!;
}
