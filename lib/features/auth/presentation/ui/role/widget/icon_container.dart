import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconContainer extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  const IconContainer({super.key, required this.isSelected, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      width: isSelected ? 55 : 50,
      height: isSelected ? 55 : 50,
      duration: const Duration(microseconds: 300),
      decoration: BoxDecoration(
        color: AppColours.primaryColor,
        borderRadius: BorderRadius.circular(isSelected ? 10.r : 8.r),),
      child: Center(
        child: Icon(icon, color: AppColours.white, size: 25.sp),
      ),
    );
    
  }
}