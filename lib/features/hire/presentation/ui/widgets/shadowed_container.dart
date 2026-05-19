import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShadowedContainer extends StatelessWidget {
  
  const ShadowedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(color: AppColours.veryLightVividTeal, blurRadius: 10.r),
        ],
      ),
    );
  }
}