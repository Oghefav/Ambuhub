import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bordered white panel used for office location and return schedule blocks.
class AddServiceFormSection extends StatelessWidget {
  final Widget child;

  const AddServiceFormSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColours.veryLightVividTeal),
      ),
      child: child,
    );
  }
}
