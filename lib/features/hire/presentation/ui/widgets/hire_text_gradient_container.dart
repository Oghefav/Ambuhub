import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireTextGradientContainer extends StatelessWidget {
  final String? text1;
  final Widget? text1Widget;
  final Color? color;
  final String? text2;
  final Color? textColor;

  const HireTextGradientContainer({
    super.key,
    this.text1,
    this.text1Widget,
    this.color,
    this.text2,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color,
        gradient: color == null
            ? const LinearGradient(
                colors: [AppColours.penBlue, AppColours.hireCyanBright],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
              )
            : null,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        spacing: 4.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          text1Widget ?? Text(text1!, style: textTheme.titleSmall?.copyWith(color: textColor, fontSize: 11.sp)),
          if (text2 != null)
            Text(text2!, style: textTheme.bodySmall)
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
