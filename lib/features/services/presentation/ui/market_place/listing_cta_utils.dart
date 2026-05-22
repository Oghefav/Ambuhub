import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shared rules for marketplace listing primary actions (cart / hire / book).
class ListingCta {
  ListingCta._();

  static String? labelFor(String listingType) {
    switch (listingType) {
      case 'hire':
        return 'Hire now';
      case 'sale':
        return 'Add to cart';
      case 'book':
        return 'Book now';
      default:
        return null;
    }
  }

  /// [forFavorites] uses marketplace card rules (favorites API often omits fields).
  static bool shouldShow(ServiceEntity service, {bool forFavorites = false}) {
    final listingType = service.listingType?.toLowerCase().trim() ?? '';
    if (listingType.isEmpty || labelFor(listingType) == null) return false;

    if (forFavorites) {
      if (listingType == 'sale' && service.price == null) return false;
      if (service.stock == 0) return false;
      if (listingType == 'book' &&
          (service.available == null || service.available == false)) {
        return false;
      }
      return true;
    }

    switch (listingType) {
      case 'sale':
        final stock = service.stock;
        return service.price != null && stock != null && stock > 0;
      case 'hire':
        return true;
      case 'book':
        return service.available != null;
      default:
        return false;
    }
  }

  static void handleTap(BuildContext context, ServiceEntity service) {
    final isLoggedIn = context.read<AuthBloc>().state.data != null;
    if (!isLoggedIn) {
      Navigator.pushNamed(context, AppRoutes.loginScreen);
      return;
    }

    switch (service.listingType?.toLowerCase()) {
      case 'sale':
        context.read<CartBloc>().add(
              AddCartItem(
                item: CartItemEntity(service: service, quantity: 1),
              ),
            );
        break;
      case 'hire':
        Navigator.pushNamed(
          context,
          AppRoutes.hireCheckoutScreen,
          arguments: service,
        );
        break;
      case 'book':
        Navigator.pushNamed(
          context,
          AppRoutes.serviceDetailScreen,
          arguments: service,
        );
        break;
    }
  }
}
