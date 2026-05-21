import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireGradientBorderContainer extends StatelessWidget {
  final Color borderColor;
  final List<Color> gradientColors;
  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  final Widget child;

  const HireGradientBorderContainer({
    super.key,
    required this.borderColor,
    required this.gradientColors,
    required this.begin,
    required this.end,
    required this.stops,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor, width: 1.5.w),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: begin,
          end: end,
          stops: stops,
        ),
      ),
      child: child,
    );
  }
}
