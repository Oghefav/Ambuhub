import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  final CartEntity? cart;
  final String? errorMessage;

  const CartState({this.cart, this.errorMessage});

  @override
  List<Object?> get props => [cart, errorMessage];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading({super.cart});
}

class CartSuccess extends CartState {
  const CartSuccess({required super.cart});
}

class CartFailure extends CartState {
  const CartFailure({required super.errorMessage, super.cart});
}
