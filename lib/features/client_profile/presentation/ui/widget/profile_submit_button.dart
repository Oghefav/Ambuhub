import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProfileSubmitButtonStyle { filled, outline }

/// Profile action button with optional loading spinner to the left of the label.
class ProfileSubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ProfileSubmitButtonStyle style;

  const ProfileSubmitButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.style = ProfileSubmitButtonStyle.filled,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDisabled = isLoading;

    final labelStyle = style == ProfileSubmitButtonStyle.filled
        ? textTheme.titleSmall!.copyWith(color: AppColours.white)
        : textTheme.titleSmall?.copyWith(
            color: isDisabled
                ? AppColours.vividTeal.withValues(alpha: 0.55)
                : AppColours.vividTeal,
            fontWeight: FontWeight.w600,
          );

    final spinnerColor = style == ProfileSubmitButtonStyle.filled
        ? AppColours.white
        : AppColours.vividTeal;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 14.w,
            height: 14.w,
            child: CupertinoActivityIndicator(
              radius: 7.r,
              color: spinnerColor,
            ),
          ),
          SizedBox(width: 8.w),
        ],
        Text(label, style: labelStyle),
      ],
    );

    if (style == ProfileSubmitButtonStyle.outline) {
      return GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColours.hireCyanBright),
          ),
          child: content,
        ),
      );
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.vividTeal,
        disabledBackgroundColor: AppColours.vividTeal.withValues(alpha: 0.55),
        disabledForegroundColor: AppColours.white,
        foregroundColor: AppColours.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: content,
    );
  }
}
