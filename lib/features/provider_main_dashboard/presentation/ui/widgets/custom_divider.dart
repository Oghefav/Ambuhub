import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      // TODO: make it align wiht appbar bottomsidecolor
      color: AppColours.veryLightVividTeal,
      height: 2.h,
    );
  }
}
