import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const SubmitButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[ Expanded(
        child: ElevatedButton(
          
          onPressed: buttonText == 'Signing in' || buttonText == 'Creating account' ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColours.blue,
            padding: EdgeInsets.symmetric(vertical: 10.h,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            buttonText,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColours.white),
          ),
        ),
      ),]
    );
  }
}
