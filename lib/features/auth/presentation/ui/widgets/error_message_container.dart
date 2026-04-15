import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorMessageContainer extends StatelessWidget {
  final String errorMessage;
  const ErrorMessageContainer({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: AppColours.veryLightVividRed
        ),
        child: Text(errorMessage, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColours.deepRed,)),
      )),]
    );
  }
}
