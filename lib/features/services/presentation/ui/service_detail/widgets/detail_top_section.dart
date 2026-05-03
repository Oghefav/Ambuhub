import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTopSection extends StatelessWidget {
  final String categoryName;
  final String deptName;
  final String? listingType;
  final String title;
  const DetailTopSection({
    super.key,
    required this.categoryName,
    required this.deptName,
    required this.title,
    this.listingType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(27, 55, 110, 1.0),
            Color.fromRGBO(27, 55, 140, 1.0),
            Color.fromRGBO(40, 39, 97, 1.0),
          ],
          stops: [0.2, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textContainer(context, categoryName.toUpperCase()),
                    SizedBox(height: 10.h),
                    _textContainer(context, deptName),
                    
                    if (listingType != null) 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        _textContainer(context,
                         listingType!.toTitleCase(), 
                         fillColor: Color.fromRGBO(19, 92, 161, 1.0),
                        //  borderColor: Colors.grey.withAlpha(100),
                         ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      title.toTitleCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: AppColours.white),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Icon(LucideIcons.calendar, color: AppColours.veryLightGrey,
                          size: 15.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Created Apr 24, 2026',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColours.veryLightGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(LucideIcons.calendar, color: AppColours.veryLightGrey, size: 15.sp,),
                        SizedBox(width: 5.w),
                        Text(
                          'Updated Apr 25, 2026',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColours.veryLightGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonContainer(
                          context,
                          text: 'Update listing',
                          icon: LucideIcons.pencil,
                        ),
                        SizedBox(width: 10.w),
                        _buttonContainer(
                          context,
                          text: 'Delete',
                          icon: LucideIcons.trash_2,
                          borderColor: Color.fromRGBO(163, 103, 132, 1.0),
                          backgroundColor: Color.fromRGBO(69, 44, 102, 1.0),
                          foregroundColor: AppColours.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _textContainer(
    BuildContext context,
    String text, {
    Color? borderColor,
    Color? fillColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: fillColor ?? Color.fromRGBO(59, 83, 135, 1.0),
        borderRadius: BorderRadius.circular(15.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: fillColor != null
              ? AppColours.white
              : AppColours.veryLightGrey,
        ),
      ),
    );
  }

  Widget _buttonContainer(
    BuildContext context, {
    required String text,
    required IconData icon,
    Color? borderColor,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColours.white,
        borderRadius: BorderRadius.circular(8.r),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: foregroundColor ?? AppColours.penBlue,
              ),
              SizedBox(width: 5.w),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: foregroundColor ?? AppColours.penBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
