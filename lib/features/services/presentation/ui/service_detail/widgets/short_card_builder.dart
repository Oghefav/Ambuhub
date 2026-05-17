import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ambuhub/config/app_colour.dart';
class ShortCardBuilder extends StatelessWidget {
  final Widget topSection;
  final Widget bottomSection;
  const ShortCardBuilder({super.key, required this.topSection, required this.bottomSection});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.white,
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: const BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Padding(padding: EdgeInsets.all(15.h),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [topSection,SizedBox(height: 10.h), bottomSection],
       ),),
      
    );
  }
}