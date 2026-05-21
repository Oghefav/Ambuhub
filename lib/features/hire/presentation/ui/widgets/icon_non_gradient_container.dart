import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconNonGradientContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final bool? addBorder;
  final Color? borderColor;
  const IconNonGradientContainer({
    super.key,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.size,
    this.addBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        border: addBorder ?? false
            ? Border.all(color: borderColor ?? AppColours.veryLightVividTeal,)
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(7.h),
        child: Icon(icon, color: iconColor, size: size),
      ),
    );
  }
}
