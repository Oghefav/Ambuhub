import 'dart:io';
import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoSection extends StatelessWidget {
  final String hintText;
  final List<File> selectedImages;
  final List<String> filePaths;
  final Function() onTap;
  final bool? isUpdate;
  const PhotoSection({
    super.key,
    this.isUpdate,
    required this.hintText,
    required this.selectedImages,
    required this.filePaths,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text('Photos', style: textTheme.titleSmall),
        Text(
          hintText,
          style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade900),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColours.penBlue,
                      AppColours.penBlue.withBlue(200),
                    ],
                    stops: const [0.5, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  color: AppColours.blue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Choose files',
                  style: textTheme.titleSmall!.copyWith(
                    color: AppColours.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            if (selectedImages.isNotEmpty && selectedImages.length == 1)
              SizedBox(
                width: 180.w,
                child: Text(
                  filePaths.first,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            if (selectedImages.length > 1)
              Text(
                '${selectedImages.length} files.',
                style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade900),
              ),
            if (selectedImages.isEmpty && isUpdate == false)
              Text(
                'No files chosen',
                style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade900),
              ),
          ],
        ),
      ],
    );
  }
}
