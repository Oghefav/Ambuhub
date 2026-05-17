import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyContentPageBuilder extends StatelessWidget {
  final String heading;
  final String description;
  final String placeholderText;
  final String? navigationText;
  final VoidCallback? onTap;
  const EmptyContentPageBuilder({
    super.key,
    required this.heading,
    required,
    required this.description,
    required this.placeholderText,
    this.navigationText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsetsGeometry.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: textTheme.displayLarge),
          SizedBox(height: 15.h),
          Text(description, style: textTheme.bodyMedium),
          SizedBox(height: 25.h),
          DottedBorderContainer(
            child: SizedBox(
              height: 150.h,
              width: double.maxFinite,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(placeholderText, style: textTheme.bodyMedium),
                    if (navigationText != null)
                         TextButton(
                          onPressed: onTap,
                          child: Text(navigationText!, style: textTheme.bodyMedium!.copyWith(color: AppColours.vividTeal)),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
