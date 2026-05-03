import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSectionContainer extends StatelessWidget {
  final String bigText;
  final String smallText;
  const TopSectionContainer({super.key, required this.bigText, required this.smallText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: AppColours.veryDarkBlue.withAlpha(30),
            blurRadius: 10.r,
            offset: Offset(0, 10.r),
            spreadRadius: -5.r,
          ),
        ],
        gradient: LinearGradient(colors: 
        [
          AppColours.veryDarkBlue,
          AppColours.penBlue,
          AppColours.veryDarkBlue

        ],
        stops: [0.0,  0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        )
        
      ),
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bigText, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColours.white)),
            SizedBox(height: 10.h),
            Text(smallText, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColours.veryLightGrey)),
          ],
        ),
      ),
    );
  }
}