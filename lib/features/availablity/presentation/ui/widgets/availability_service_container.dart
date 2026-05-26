import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/update_service_availability/update_service_availability_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailabilityServiceContainer extends StatelessWidget {
  final ServiceEntity service;
  final bool isUpdating;

  const AvailabilityServiceContainer({
    super.key,
    required this.service,
    required this.isUpdating,
  });

  static final double _imageSize = 80.r;

  bool get _isAvailable => service.available == true;

  Widget _listingPhotoPlaceholder() {
    return Container(
      height: _imageSize,
      width: _imageSize,
      color: AppColours.veryLightVividTeal.withValues(alpha: 0.2),
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final photoUrl = service.photoUrls.isNotEmpty
        ? service.photoUrls.first.trim()
        : '';
    final hintStyle = textTheme.titleSmall?.copyWith(
      fontSize: 11.sp,
      color: AppColours.vividBlue,
    );

    return Card(
      color: AppColours.white,
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: const BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: photoUrl.isEmpty
                    ? _listingPhotoPlaceholder()
                    : CachedNetworkImage(
                        imageUrl: photoUrl,
                        height: _imageSize,
                        width: _imageSize,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        placeholder: (_, __) => _listingPhotoPlaceholder(),
                        errorWidget: (_, __, ___) =>
                            _listingPhotoPlaceholder(),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.dept.toUpperCase(),
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColours.vividBlue,
                          fontSize: 11.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        service.title.capitalizeFirst(),
                        style: textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.updateServiceScreen,
                            arguments: service,
                          );
                        },
                        child: Text('Edit listing', style: hintStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
            child: Row(
              children: [
                Text(
                  _isAvailable ? 'Available' : 'Not available',
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: _isAvailable ? AppColours.hireForest : null,
                    fontWeight: _isAvailable
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                SizedBox(width: 5.h),
                CupertinoSwitch(
                  value: _isAvailable,
                  activeTrackColor: AppColours.hireForest,
                  inactiveTrackColor:
                      AppColours.grey.withValues(alpha: 0.35),
                  onChanged: isUpdating
                      ? null
                      : (value) {
                          context.read<UpdateServiceAvailabilityBloc>().add(
                                UpdateServiceAvailability(
                                  serviceId: service.id,
                                  isAvailable: value,
                                ),
                              );
                        },
                ),
                SizedBox(width: 5.h),
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: isUpdating
                      ? const CupertinoActivityIndicator(
                          color: AppColours.blue,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
