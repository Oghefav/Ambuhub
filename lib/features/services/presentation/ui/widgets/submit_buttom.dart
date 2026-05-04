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
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: LinearGradient(
                colors: onPressed == null
                    ? [
                        Color.fromRGBO(122, 143, 191, 1.0),
                        Color.fromRGBO(107, 173, 199, 1.0),
                      ]
                    : [
                        AppColours.penBlue,
                        Color.fromRGBO(0, 115, 150, 1.0),
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: AppColours.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
