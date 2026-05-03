import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorSection extends StatelessWidget {
  final Function() onPressed;
  final String errorMessage;
  const ErrorSection({
    super.key,
    required this.onPressed,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.wifi_off, size: 40.sp),
        SizedBox(height: 10.h),
        Text(errorMessage, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 10.h),
        TextButton(
          onPressed: onPressed,
          child: Text(
            ' Tap to retry',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColours.blue,
            ),
          ),
        ),
      ],
    );
  }
}
