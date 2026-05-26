import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/dotted_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderNotificationsEmptyState extends StatelessWidget {
  const ProviderNotificationsEmptyState({super.key});

  static const String _placeholderText =
      'No notifications yet. You will be notified when someone buys or hires your listings.';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DottedBorderContainer(
      borderColor: AppColours.veryLightVividTeal,
      child: SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12.h,
              children: [
                Icon(
                  LucideIcons.bell,
                  color: AppColours.vividTeal,
                  size: 28.sp,
                ),
                Text(
                  _placeholderText,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 11.sp,
                    color: AppColours.grey,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
