import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceSubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const ServiceSubmitButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                gradient: LinearGradient(
                  colors: onPressed == null
                      ? [
                          AppColours.softBlue,
                          AppColours.softTeal,
                        ]
                      : [
                          AppColours.penBlue,
                          AppColours.deepTeal,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Center(
                  child: Text(
                    buttonText,
                    style: textTheme.titleSmall!.copyWith(color: AppColours.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
