import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_event.dart';
import 'package:ambuhub/features/favorite/presentation/bloc/favorite/favorite_state.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/favorite/presentation/ui/widgets/favorite_display_utils.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/listing_cta_utils.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/shadow_container_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailActionsSection extends StatelessWidget {
  final ServiceEntity service;

  static const Color _borderColor = AppColours.hireCyanIce;

  const ClientDetailActionsSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lightFill = Color.lerp(_borderColor, AppColours.white, 0.92)!;
    final listingType = service.listingType?.toLowerCase() ?? '';
    final ctaLabel = ListingCta.labelFor(listingType);
    final showCta = ListingCta.shouldShow(service);

    return ShadowContainerTemplate(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10.h,
          children: [
            Text(
              'ACTIONS',
              style: textTheme.titleSmall?.copyWith(
                color: AppColours.teal,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Purchase, hire, or save this listing.',
              style: textTheme.bodySmall?.copyWith(
                fontSize: 10.sp,
                color: AppColours.grey,
              ),
            ),
            _FavoriteActionChip(
              serviceId: service.id,
              borderColor: _borderColor,
              backgroundColor: lightFill,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: _actionChip(
                backgroundColor: lightFill,
                child: Text(
                  'More in this category',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColours.vividTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ),
            if (showCta)
              SizedBox(
                width: double.infinity,
                child: _actionChip(
                backgroundColor: lightFill,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10.h,
                  children: [
                    _TopPriceLabel(
                      price: service.price,
                      pricePeriod:
                          listingType == 'sale' ? null : service.pricePeriod,
                      textTheme: textTheme,
                    ),
                    _PrimaryListingButton(
                      service: service,
                      listingType: listingType,
                      label: ctaLabel!,
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

  Widget _actionChip({
    required Color backgroundColor,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _borderColor),
      ),
      child: child,
    );
  }
}

class _FavoriteActionChip extends StatelessWidget {
  final String serviceId;
  final Color borderColor;
  final Color backgroundColor;

  const _FavoriteActionChip({
    required this.serviceId,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLoggedIn = context.read<AuthBloc>().state.data != null;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) =>
          previous.favoriteServiceIds != current.favoriteServiceIds ||
          previous.pendingServiceId != current.pendingServiceId,
      builder: (context, state) {
        final isPending =
            state is FavoriteLoading && state.pendingServiceId == serviceId;
        final status = favoriteDisplayStatus(serviceId, state);
        final isFavorited = status == FavoriteDisplayStatus.favorited;
        final iconColor =
            isFavorited ? AppColours.rosePink : AppColours.vividTeal;
        const textColor = AppColours.vividTeal;
        final label = isFavorited
            ? 'Remove from favourites'
            : 'Add to favourites';

        return GestureDetector(
          onTap: isPending
              ? null
              : () {
                  if (!isLoggedIn) {
                    Navigator.pushNamed(context, AppRoutes.loginScreen);
                    return;
                  }
                  context.read<FavoriteBloc>().add(
                        ToggleFavorite(serviceId: serviceId),
                      );
                },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5.w,
              children: [
                if (isPending)
                  SizedBox(
                    width: 14.sp,
                    height: 14.sp,
                    child: CupertinoActivityIndicator(
                      radius: 7.sp,
                      color: AppColours.vividTeal,
                    ),
                  )
                else
                  Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_outline,
                    color: iconColor,
                    size: 14.sp,
                  ),
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopPriceLabel extends StatelessWidget {
  final int? price;
  final String? pricePeriod;
  final TextTheme textTheme;

  const _TopPriceLabel({
    required this.price,
    required this.pricePeriod,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = formatCurrency(price ?? 0);
    final period = pricePeriod?.trim().toLowerCase();

    return RichText(
      text: TextSpan(
        style: textTheme.bodySmall?.copyWith(fontSize: 10.sp),
        children: [
          TextSpan(
            text: priceText,
            style: textTheme.titleSmall?.copyWith(
              color: AppColours.darkVividTeal,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
          if (period != null && period.isNotEmpty)
            TextSpan(
              text: ' (per $period)',
              style: textTheme.bodySmall?.copyWith(
                color: AppColours.grey,
                fontSize: 9.sp,
              ),
            ),
        ],
      ),
    );
  }
}

class _PrimaryListingButton extends StatelessWidget {
  final ServiceEntity service;
  final String listingType;
  final String label;

  const _PrimaryListingButton({
    required this.service,
    required this.listingType,
    required this.label,
  });

  static const List<Color> _gradientColors = [
    AppColours.hireCyanBright,
    AppColours.hireCyanDeep,
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (listingType == 'sale') {
      return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) =>
            previous.pendingServiceId != current.pendingServiceId ||
            previous.runtimeType != current.runtimeType,
        builder: (context, cartState) {
          final isAdding = cartState is CartLoading &&
              cartState.isAddingToCart &&
              cartState.pendingServiceId == service.id;

          return GestureDetector(
            onTap: isAdding ? null : () => _onPressed(context),
            child: _gradientShell(
              child: isAdding
                  ? SizedBox(
                      height: 18.h,
                      child: const Center(
                        child: CupertinoActivityIndicator(
                          color: AppColours.white,
                        ),
                      ),
                    )
                  : Text(
                      label,
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColours.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => _onPressed(context),
      child: _gradientShell(
        child: Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            color: AppColours.white,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    ListingCta.handleTap(context, service);
  }

  Widget _gradientShell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: _gradientColors,
          stops: [0.0, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
