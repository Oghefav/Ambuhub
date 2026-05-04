import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceContainer extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ServiceContainer({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationCubit>(context).setPage('');
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.serviceDetailScreen,
          arguments: serviceEntity,
        );
      },
      child: Card(
        color: AppColours.white,
        margin: EdgeInsets.only(bottom: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(color: AppColours.veryLightVividTeal),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
              child: Image.network(
                serviceEntity.photoUrls.first,
                height: 130.h,
                width: 100.w,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 80.h,
                    width: 100.w,
                    color: AppColours.veryLightVividTeal.withOpacity(0.2),
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
                // Optional: Add a loading spinner while the image downloads
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 100.w,
                    child: Center(
                      child: CupertinoActivityIndicator(color: AppColours.blue),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceEntity.dept.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColours.vividBlue, fontSize: 13.sp),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      serviceEntity.title.toTitleCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // SizedBox(height: 10.h),
                    Text(
                      serviceEntity.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // SizedBox(height: 10.h),
                    Text(
                      'View details',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColours.vividBlue, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
