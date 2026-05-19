import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  final CartEntity? cart;
  final String? errorMessage;
  /// Set while [AddCartItem] is in flight so only that service card shows loading.
  final String? pendingServiceId;

  const CartState({this.cart, this.errorMessage, this.pendingServiceId});

  int get totalItemCount {
    final items = cart?.items;
    if (items == null || items.isEmpty) return 0;
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props =>
      [totalItemCount, cart?.totalPrice, errorMessage, pendingServiceId];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  /// True only while [AddCartItem] is in flight (marketplace "Added to cart" UI).
  final bool isAddingToCart;

  const CartLoading({
    super.cart,
    super.pendingServiceId,
    this.isAddingToCart = false,
  });

  @override
  List<Object?> get props => [...super.props, isAddingToCart];
}

class CartSuccess extends CartState {
  const CartSuccess({required super.cart});
}

class CartFailure extends CartState {
  const CartFailure({required super.errorMessage, super.cart});
}
