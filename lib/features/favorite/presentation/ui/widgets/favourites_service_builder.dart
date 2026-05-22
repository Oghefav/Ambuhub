import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/build_header.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_non_gradient_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/provider_main_dashboard/presentation/cubit/navigation_cubit.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/listing_cta_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/service_detail/market_place_service_detail_args.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesServiceBuilder extends StatelessWidget {
  final List<ServiceEntity> services;
  final List<ServiceCategoryEntity> serviceCategories;
  final String emptyDescription;
  final String navigationText;
  final Gradient gradient;
  const FavouritesServiceBuilder({super.key, required this.services, required this.serviceCategories, required this.emptyDescription, required this.navigationText, required this.gradient});
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 20.h),
      itemCount: services.length + 1,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: BuildHeader(
              emptyDescription: emptyDescription,
              gradient: gradient,
            ),
          );
        }
        return _buildServiceItem(context, services[index - 1]);
      },
    );
  }

  Widget _buildServiceItem(BuildContext context, ServiceEntity service) {
    final showListingCta = ListingCta.shouldShow(service, forFavorites: true);
    final listingCtaLabel =
        ListingCta.labelFor(service.listingType?.toLowerCase() ?? '');

    return ShadowedContainer(
        topStops: const [0.0, 0.5, 1.0],
        bodyStops: const [0.0, 0.1],
        shadowColor: Color.lerp(
          AppColours.hireMagentaRose,
          AppColours.white,
          0.8,
        )!,
        borderColor: AppColours.hireMagentaRose,
        topGradientColors: const [
      
          AppColours.rosePink,
          AppColours.hireMagentaRose,
          AppColours.penBlue,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        bodyGradientColors: [
          Color.lerp(AppColours.hireMagentaRose, AppColours.white, 0.6)!,
          Color.lerp(AppColours.hireMagentaRose, AppColours.white, 0.95)!,
        ],
        body: SizedBox(
          width: double.infinity,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.w,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: service.photoUrls.first,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return const Center(child: CupertinoActivityIndicator());
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        service.listingType?.toUpperCase() ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                          color: AppColours.rosePink,
                        ),
                      ),
                      Text(
                        service.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColours.hirePurpleDeep,
                        ),
                      ),
                      Text(
                        'Stock: ${service.stock}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<FavoriteBloc>().add(RemoveFavorite(serviceId: service.id));
                  },
                  child: IconNonGradientContainer(
                    icon: LucideIcons.trash_2,
                    addBorder: true,
                    borderColor: AppColours.hireMagentaRose,
                    color: AppColours.white,
                    iconColor: AppColours.hireMagentaRose,
                    size: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              service.description,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
            ),
            SizedBox(height: 15.h),
            Divider(
              color: Color.lerp(AppColours.hireMagentaRose, AppColours.white, 0.8)!,
              thickness: 1,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.marketPlaceServiceDetailScreen,
                  arguments: MarketPlaceServiceDetailArgs.fromService(
                    service,
                    returnTarget: ServiceDetailReturnTarget.favourites,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColours.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColours.hireMagentaRose),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5.w,
                      children: [
                        Text(
                          'View Details',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10.sp,
                            color: AppColours.hirePurpleDeep,
                          ),
                        ),
                        Icon(
                          LucideIcons.external_link,
                          size: 10.sp,
                          color: AppColours.teal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showListingCta && listingCtaLabel != null) ...[
              SizedBox(height: 10.h),
              _FavoriteListingCtaButton(
                service: service,
                label: listingCtaLabel,
              ),
            ],
            if (!showListingCta) ...[
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Listing details',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10.sp,
                        color: AppColours.vividTeal,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColours.hirePurpleDeep,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<NavigationCubit>()
                              .setPage('clientDashboard');
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.clientDashBoardScreen,
                          );
                        },
                    ),
                    TextSpan(
                      text:
                          ' shows all photos and the full description. To book, use the ',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                    ),
                    TextSpan(
                      text: service.serviceCategory,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10.sp,
                        color: AppColours.vividTeal,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        decorationColor: AppColours.hirePurpleDeep,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          final category = serviceCategories.firstWhere(
                            (element) =>
                                element.name == service.serviceCategory,
                          );
                          context.read<NavigationCubit>().setPage('');
                          Navigator.pushNamed(
                            context,
                            AppRoutes.markerScreen,
                            arguments: category,
                          );
                        },
                    ),
                    TextSpan(
                      text: ' category page.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        ),
    );
  }
}

class _FavoriteListingCtaButton extends StatelessWidget {
  final ServiceEntity service;
  final String label;

  const _FavoriteListingCtaButton({
    required this.service,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isSale = service.listingType?.toLowerCase() == 'sale';

    Widget labelWidget(String text) {
      return Center(
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(
            fontSize: 10.sp,
            color: AppColours.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final decoration = BoxDecoration(
      color: AppColours.vividTeal,
      borderRadius: BorderRadius.circular(8.r),
    );

    if (!isSale) {
      return GestureDetector(
        onTap: () => ListingCta.handleTap(context, service),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: decoration,
          child: labelWidget(label),
        ),
      );
    }

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.pendingServiceId != current.pendingServiceId ||
          previous.runtimeType != current.runtimeType,
      builder: (context, cartState) {
        final isAdding = cartState is CartLoading &&
            cartState.isAddingToCart &&
            cartState.pendingServiceId == service.id;

        return GestureDetector(
          onTap: isAdding ? null : () => ListingCta.handleTap(context, service),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: decoration,
            child: isAdding
                ? SizedBox(
                    height: 16.h,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColours.white,
                      ),
                    ),
                  )
                : labelWidget(label),
          ),
        );
      },
    );
  }
}
