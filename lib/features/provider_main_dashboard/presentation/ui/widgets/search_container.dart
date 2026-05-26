import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;

  const SearchContainer({
    super.key,
    required this.searchController,
    this.hintText = 'Search listings, notifications, and bookings...',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColours.veryDarkBlue,
      elevation: 4,
      shadowColor: AppColours.penBlue,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              
            ]
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search listings, messages, and bookings...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              prefixIcon: Icon(
                LucideIcons.search,
                color: AppColours.grey,
                size: 18.sp,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
