import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final bool fullWidth;

  const SubmitButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.textStyle,
    this.fullWidth = true,
  });

  static bool isLoadingLabel(String buttonText) {
    return buttonText == 'Logging in' ||
        buttonText == 'Creating account' ||
        buttonText == 'Updating' ||
        buttonText == 'Saving';
  }

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoadingLabel(buttonText) || onPressed == null ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColours.primaryColor,
        disabledBackgroundColor: AppColours.secondaryBlue,
        disabledForegroundColor: AppColours.white,
        foregroundColor: AppColours.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        buttonText,
        style: textStyle ??
            Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColours.white),
      ),
    );

    if (!fullWidth) {
      return button;
    }

    return Row(
      children: [
        Expanded(child: button),
      ],
    );
  }
}
