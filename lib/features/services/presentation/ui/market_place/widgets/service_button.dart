import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceButtonSection extends StatelessWidget {
  final ServiceEntity service;
  const ServiceButtonSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = BlocProvider.of<AuthBloc>(context).state.data != null;
    if (!_shouldhaveButtonSection()) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        CartItemEntity? cartItem;
        final cart = state.cart;
        if (cart != null) {
          for (final item in cart.items) {
            if (item.service.id == service.id) {
              cartItem = item;
              break;
            }
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: AppColours.veryLightVividTeal),
            if (cartItem != null)
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 4.h),
                child: Text(
                  'In cart: ${cartItem.quantity}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColours.vividTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 8.sp,
                  ),
                ),
              ),
            if (_shouldShowButton())
              GestureDetector(
                onTap: () {
                  if (_isAddingThisService(state)) return;
                  _onPressed(context);
                },
                child: Center(
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isLoggedIn ? AppColours.vividTeal : null,
                      border: !isLoggedIn
                          ? Border.all(color: AppColours.vividTeal)
                          : null,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(child: _getForegroundWidget(context)),
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                child: Text(
                  _getNoButtonText(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 10.sp),
                ),
              ),
          ],
        );
      },
    );
  }

  bool _shouldShowButton() {
    final bool shouldNotShowButton =
        ((service.available == null || service.available == false) &&
            service.listingType?.toLowerCase() == 'book') ||
        service.stock == 0 ||
        service.listingType == null ||
        (service.listingType?.toLowerCase() == 'sale' && service.price == null);
    if (shouldNotShowButton) return false;
    return true;
  }

  void _onPressed(BuildContext context) {
    final isLoggedIn = context.read<AuthBloc>().state.data != null;
    if (!isLoggedIn) {
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    } else {
      if (service.listingType?.toLowerCase() == 'sale') {
        context.read<CartBloc>().add(
          AddCartItem(item: CartItemEntity(service: service, quantity: 1)),
        );
      } else if (service.listingType?.toLowerCase() == 'hire') {
        Navigator.pushNamed(
          context,
          AppRoutes.hireCheckoutScreen,
          arguments: service,
        );
      } else if (service.listingType?.toLowerCase() == 'book') {
        // TODO: Implement book logic
        Navigator.pushNamed(
          context,
          AppRoutes.serviceDetailScreen,
          arguments: service,
        );
      }
    }
  }

  Widget _getForegroundWidget(BuildContext context) {
    final isLoggedIn = context.read<AuthBloc>().state.data != null;
    final textTheme = Theme.of(context).textTheme.bodySmall!.copyWith(
      color: isLoggedIn ? AppColours.white : AppColours.vividTeal,
      fontWeight: FontWeight.w600,
    );
    if (!isLoggedIn) {
      if (service.listingType?.toLowerCase() == 'sale') {
        return Text('Log in to purchase', style: textTheme);
      } else if (service.listingType?.toLowerCase() == 'hire') {
        return Text('Log in to hire', style: textTheme);
      } else if (service.listingType?.toLowerCase() == 'book') {
        return Text('Log in to book', style: textTheme);
      }
    } else {
      if (service.listingType?.toLowerCase() == 'sale') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 10.w,
          children: [
            BlocSelector<CartBloc, CartState, bool>(
              selector: _isAddingThisService,
              builder: (context, isLoading) {
                return isLoading
                    ? SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: AppColours.veryLightGrey,
                        ),
                      )
                    : Icon(
                        LucideIcons.shopping_cart,
                        size: 15.sp,
                        color: AppColours.white,
                      );
              },
            ),
            Text('Add to Cart', style: textTheme.copyWith(fontSize: 10.sp)),
          ],
        );
      } else if (service.listingType?.toLowerCase() == 'hire') {
        return Text('Hire now', style: textTheme);
      } else if (service.listingType?.toLowerCase() == 'book') {
        return Text('Book now', style: textTheme);
      }
    }
    return const SizedBox.shrink();
  }

  bool _isAddingThisService(CartState state) {
    return state is CartLoading && state.pendingServiceId == service.id;
  }
  
  bool _shouldhaveButtonSection() {
    final bool shouldNotShowButton =
        service.listingType?.toLowerCase() == 'sale' && service.price == null ||
        service.stock == 0;
    if (shouldNotShowButton) return false;
    return true;
  }

  String _getNoButtonText() {
    if (service.available == null || service.available == false) {
      return ' This listing is not available for booking';
    }
    return '';
  }
}
