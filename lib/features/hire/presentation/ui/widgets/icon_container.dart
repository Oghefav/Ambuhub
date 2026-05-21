import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconGradientContainer extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  final double size;
  final List<double> gradientStops;

  const IconGradientContainer({
    super.key,
    required this.icon,
    required this.colors,
    required this.size,
    required this.gradientStops,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: gradientStops,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: AppColours.white, size: size),
    );
  }
}
