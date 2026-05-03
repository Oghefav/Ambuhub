import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallGradientContainer extends StatelessWidget {
  final IconData iconData;
  final String title;
  const SmallGradientContainer({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: 
        [AppColours.vividBlue, AppColours.veryLightBlue],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      
      ),
      borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
      child: Row(children: [
        Icon(iconData, color: AppColours.white, size: 18.sp,),
        SizedBox(width: 10.w),
        Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColours.white),),
      ],)
      ),
    );
  }
}