import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceContainer extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ServiceContainer({super.key, required this.serviceEntity});

  Widget _listingPhotoPlaceholder({double? height, double? width}) {
    return Container(
      height: height ?? 130.h,
      width: width ?? 100.w,
      color: AppColours.veryLightVividTeal.withOpacity(0.2),
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final photoUrl = serviceEntity.photoUrls.isNotEmpty
        ? serviceEntity.photoUrls.first.trim()
        : '';
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
          side: const BorderSide(color: AppColours.veryLightVividTeal),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
              child: photoUrl.isEmpty
                  ? _listingPhotoPlaceholder()
                  : CachedNetworkImage(
                      imageUrl: photoUrl,
                      height: 130.h,
                      width: 100.w,
                      fit: BoxFit.fitHeight,
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      progressIndicatorBuilder: (_, __, ___) => SizedBox(
                        height: 130.h,
                        width: 100.w,
                        child: const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColours.blue,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => _listingPhotoPlaceholder(),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.h,
                  children: [
                    Text(
                      serviceEntity.dept.toUpperCase(),
                      style: textTheme.titleSmall!.copyWith(
                        color: AppColours.vividBlue, fontSize: 11.sp),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      serviceEntity.title.capitalizeFirst(),
                      style: textTheme.titleSmall!.copyWith(fontSize: 12.sp),
                    ),
                    // SizedBox(height: 10.h),
                    Text(
                      serviceEntity.description.capitalizeFirst(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!.copyWith(fontSize: 11.sp),
                    ),
                    // SizedBox(height: 10.h),
                    Text(
                      'View details',
                      style: textTheme.titleSmall!.copyWith(
                        color: AppColours.vividBlue, fontSize: 11.sp),
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
