import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBuilder extends StatelessWidget {
  final String titleText;
  const CardBuilder({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadiusGeometry.circular(15.r),
        border: Border.all(color: AppColours.veryLightVividTeal, width: 2),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight(500),
              color: AppColours.grey,
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(color: Colors.black),
          ),
          SizedBox(height: 20.h),
          Text('Placeholder', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
