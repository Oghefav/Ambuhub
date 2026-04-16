import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(

      options: RoundedRectDottedBorderOptions(
        strokeWidth: 2,
        dashPattern: [6,3],
        
        color: AppColours.veryLightVividTeal,
        radius: Radius.circular(15.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColours.white),
        child: child,
        
      ),
    );
  }
}
