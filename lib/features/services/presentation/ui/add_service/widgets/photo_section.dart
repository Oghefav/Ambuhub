import 'dart:io';

import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoSection extends StatelessWidget {
  final List<File> selectedImages;
  final List<String> filePaths;
  final Function() onTap;
  const PhotoSection({super.key, required this.selectedImages, required this.filePaths, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text('Photos', style: Theme.of(context).textTheme.titleSmall),
        Text(
          'Images only (JPEG, PNG, WebP, etc.). Up to 10 files, 5MB each.',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade900),
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
                    colors: [AppColours.penBlue, AppColours.penBlue.withBlue(200)],
                    stops: [0.5, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    ),
                  color: AppColours.blue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Choose files',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: AppColours.white, fontSize: 13.sp),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            if (selectedImages.isNotEmpty &&
                selectedImages.length == 1)
              Text(filePaths.first, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade900)),
            if (selectedImages.length > 1)
              Text('${selectedImages.length} files.', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade900)),
            if (selectedImages.isEmpty)
              Text('No files chosen', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade900)),
          ],
        ),
      ],
    );
  }
}