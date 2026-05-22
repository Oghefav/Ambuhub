import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveReceiptContainer extends StatelessWidget {
  const SaveReceiptContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColours.hireCyanBright),
        ),
        alignment: Alignment.center,
        child: Text(
          'Print/ Save as PDF',
          textAlign: TextAlign.center,
          style: textTheme.titleSmall?.copyWith(
            color: AppColours.darkVividTeal,
          ),
        ),
      ),
    );
  }
}
