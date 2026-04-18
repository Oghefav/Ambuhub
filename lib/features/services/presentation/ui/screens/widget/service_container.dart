import 'package:ambuhub/config/app_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceContainer extends StatelessWidget {
  final String imageurl;
  final String dept;
  final String description;
  final String title;
  const ServiceContainer({
    super.key,
    required this.dept,
    required this.description,
    required this.imageurl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(topLeft:  Radius.circular(15.r),bottomLeft: Radius.circular(15.r) ),
            child: Image.network(
              imageurl,
              height: 120.h,
              width: 100.w,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 80.h,
                  width: 100,
                  color: AppColours.veryLightVividTeal.withOpacity(0.2),
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
              // Optional: Add a loading spinner while the image downloads
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 80.h,
                  width: 100,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dept.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 10.h),
                  Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
