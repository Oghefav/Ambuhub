import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/favorite_icon_button.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/market_place_service_detail_args.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/service_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemBuilder extends StatelessWidget {
  final ServiceEntity service;
  const ServiceItemBuilder({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.marketPlaceServiceDetailScreen,
          arguments: MarketPlaceServiceDetailArgs(
            serviceId: service.id,
            returnTarget: ServiceDetailReturnTarget.category,
            returnLabel: 'Back to ${service.serviceCategory}',
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 30.h, right: 10.w),
        color: AppColours.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: const BorderSide(color: AppColours.veryLightVividTeal),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: service.photoUrls[0],
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColours.blue,
                          ),
                        ),
                    errorWidget: (context, url, error) => const SizedBox.shrink(),
                    fit: BoxFit.fill,
                    height: 150.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    height: 40.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FavoriteIconButton(serviceId: service.id),
                    ),
                  ),
                ),
                if (service.listingType != null)
                  Positioned(
                    bottom: 10.h,
                    left: 10.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        service.listingType!.toUpperCase(),
                        style: textTheme.titleSmall!.copyWith(
                          color: AppColours.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!.copyWith(fontSize: 11.sp),
                  ),
                  if (service.price != null) ...[
                    SizedBox(height: 5.h),
                    Text(
                      '${formatCurrency(service.price)} (per ${service.pricePeriod ?? ''})',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall!.copyWith(fontSize: 9.sp),
                    ),
                  ],
                  SizedBox(height: 5.h),
                  Text(
                    'Stock: ${service.stock?.toString() ?? 'N/A'}',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall!.copyWith(fontSize: 9.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    service.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: textTheme.bodySmall!.copyWith(fontSize: 9.sp),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            Expanded(
              child: Center(child: ServiceButtonSection(service: service)),
            ),
          ],
        ),
      ),
    );
  }
  
}
