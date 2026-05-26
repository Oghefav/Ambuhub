import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Outlined action chip used for secondary actions (e.g. mark all as read).
class BorderedActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const BorderedActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColours.white,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColours.veryLightVividTeal),
          ),
          child: Center(
            child: isLoading
                ? const CupertinoActivityIndicator(color: AppColours.vividTeal)
                : Text(
                    label,
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColours.vividTeal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
