import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeptSectionBuilder extends StatelessWidget {
  final String deptName;
  final List<ServiceEntity> services;
  final bool? isLoggedIn;
  const DeptSectionBuilder({
    super.key,
    required this.deptName,
    required this.services,
    this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    final int servicesLength = services.length;
    final textTheme = Theme.of(context).textTheme;
    return SliverPadding(
      padding: EdgeInsets.only(left: 15.w),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(deptName, style: textTheme.titleSmall),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 290.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: servicesLength,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 180.w,
                    child: _serviceItemBuilder(context, services[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceItemBuilder(BuildContext context, ServiceEntity service) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.only(bottom: 30.h, right: 10.w),
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),

        side: const BorderSide(color: AppColours.veryLightVividTeal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 7 / 5,
            child: Stack(
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
                    errorWidget: (context, url, error) =>
                        const SizedBox.shrink(),
                    fit: BoxFit.fill,
                    width: double.infinity,
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                ),
                if (service.price != null) ...[
                  SizedBox(height: 5.h),
                  Text(
                    formatCurrency(service.price),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!.copyWith(fontSize: 13.sp),
                  ),
                ],
                SizedBox(height: 5.h),
                Text(
                  'Stock: ${service.stock?.toString() ?? 'N/A'}',
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 5.h),
                Text(
                  service.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
