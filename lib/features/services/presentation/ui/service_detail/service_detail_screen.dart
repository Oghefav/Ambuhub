import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/widgets/provider_app_scaffold.dart';
import 'package:ambuhub/core/widgets/custom_appbar.dart';
import 'package:ambuhub/dependencies_injection.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/delete_service/delete_service_state.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_bloc.dart';
import 'package:ambuhub/features/services/presentation/bloc/get_provider_services/get_provider_services_event.dart';
import 'package:ambuhub/features/services/presentation/ui/add_service/utils/add_service_pricing_period.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/detail_top_section.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/service_office_location_section.dart';
import 'package:ambuhub/features/services/presentation/ui/service_detail/widgets/short_card_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceEntity service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pricePeriodLine = pricePeriodPerLine(service.pricePeriod);

    return BlocProvider(
      create: (_) => sl<DeleteServiceBloc>(),
      child: BlocListener<DeleteServiceBloc, DeleteServiceState>(
        listener: (context, state) {
          if (state is DeleteServiceSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            context.read<GetProviderServicesBloc>()
              ..invalidateProviderListings()
              ..add(const GetProviderServices(forceRefresh: true));
            context.read<NavigationCubit>().setPage('listings');
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.listingsScreen,
            );
          }
        },
        child: ProviderAppScaffold(
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
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.listingsScreen,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.arrow_left,
                          size: 16.sp,
                          color: AppColours.penBlue,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'My listings',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColours.penBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  DetailTopSection(service: service),
                  SizedBox(height: 15.h),
                  if (service.photoUrls.isNotEmpty)
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
                  if (service.photoUrls.isNotEmpty) SizedBox(height: 15.h),
                  ShortCardBuilder(
                    topSection: _cardHeader(
                      context,
                      icon: LucideIcons.tag,
                      iconColor: AppColours.blue,
                      label: 'PRICE',
                      labelColor: AppColours.blue,
                    ),
                    bottomSection: service.price != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatCurrency(service.price),
                                style: textTheme.titleSmall?.copyWith(
                                  color: AppColours.veryDarkBlue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              if (pricePeriodLine != null) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  pricePeriodLine,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColours.grey,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ],
                          )
                        : _lineWidget(),
                  ),
                  ShortCardBuilder(
                    topSection: _cardHeader(
                      context,
                      icon: LucideIcons.layers,
                      iconColor: AppColours.darkTealAccent,
                      label: 'STOCK',
                      labelColor: AppColours.darkTealAccent,
                    ),
                    bottomSection: service.stock != null
                        ? Text(
                            service.stock.toString(),
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          )
                        : _lineWidget(),
                  ),
                  ShortCardBuilder(
                    topSection: _cardHeader(
                      context,
                      label: 'LISTING TYPE',
                      labelColor: AppColours.vividPurple,
                    ),
                    bottomSection: service.listingType != null
                        ? Text(
                            service.listingType.toString().toTitleCase(),
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          )
                        : _lineWidget(),
                  ),
                  ServiceOfficeLocationSection(service: service),
                  ShortCardBuilder(
                    topSection: _cardHeader(
                      context,
                      label: 'DESCRIPTION',
                      labelColor: AppColours.softIndigo,
                    ),
                    bottomSection: Text(
                      service.description,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardHeader(
    BuildContext context, {
    IconData? icon,
    Color? iconColor,
    required String label,
    required Color labelColor,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14.sp, color: iconColor),
          SizedBox(width: 8.w),
        ],
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: labelColor,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _lineWidget() {
    return Container(
      color: AppColours.veryDarkBlue,
      width: 12.w,
      height: 2.h,
    );
  }
}
