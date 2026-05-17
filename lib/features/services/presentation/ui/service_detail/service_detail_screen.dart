import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/detail_top_section.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/short_card_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceEntity service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ProviderAppScaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.listingsScreen),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.arrow_left,
                          size: 20.sp,
                          color: AppColours.penBlue,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'My listings',
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColours.penBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  DetailTopSection(service: service),
                  SizedBox(height: 15.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      imageUrl: service.photoUrls.first,
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      height: 200.h,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image_outlined),
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(child: CupertinoActivityIndicator()),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ShortCardBuilder(
                    topSection: Row(
                      children: [
                        Icon(
                          LucideIcons.tag,
                          size: 20.sp,
                          color: AppColours.blue,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'PRICE',
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColours.blue,
                          ),
                        ),
                      ],
                    ),
                    bottomSection: service.price != null
                        ? Text(
                            formatCurrency(service.price),
                            style: textTheme.titleSmall!.copyWith(
                              color: AppColours.veryDarkBlue,
                            ),
                          )
                        : _lineWidget(),
                  ),
                  ShortCardBuilder(
                    topSection: Row(
                      children: [
                        Icon(
                          LucideIcons.layers,
                          size: 20.sp,
                          color: AppColours.darkTealAccent,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'STOCK',
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColours.darkTealAccent,
                          ),
                        ),
                      ],
                    ),
                    bottomSection: service.stock != null
                        ? Text(
                            service.stock.toString(),
                            style: textTheme.titleLarge,
                          )
                        : _lineWidget(),
                  ),
                  ShortCardBuilder(
                    topSection: Row(
                      children: [
                        Text(
                          'LISTING TYPE',
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColours.vividPurple,
                          ),
                        ),
                      ],
                    ),
                    bottomSection: service.listingType != null
                        ? Text(
                            service.listingType.toString().toTitleCase(),
                            style: textTheme.titleLarge,
                          )
                        : _lineWidget(),
                  ),
                  ShortCardBuilder(
                    topSection: Row(
                      children: [
                        Text(
                          'DESCRITION',
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColours.softIndigo,
                          ),
                        ),
                      ],
                    ),
                    bottomSection: Text(
                      service.description,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lineWidget() {
    return Container(color: AppColours.veryDarkBlue, width: 15.w, height: 3.h);
  }
}
