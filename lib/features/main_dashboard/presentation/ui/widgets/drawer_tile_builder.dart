import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerTileBuilder extends StatelessWidget {
  final IconData iconData;
  final String title;
  final GestureTapCallback onTap;
  final bool isSelected;
  // final int index;
  final Color? color;
  const DrawerTileBuilder({
    super.key,
    required this.iconData,
    required this.onTap,
    // required this.index,
    required this.isSelected,
    required this.title,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),

        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: AppColours.teal, ) : null,
          color: isSelected ? AppColours.penBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColours.veryLightGrey,
            ),
            SizedBox(width: 20.w),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight(600),
                      color: AppColours.veryLightGrey
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
