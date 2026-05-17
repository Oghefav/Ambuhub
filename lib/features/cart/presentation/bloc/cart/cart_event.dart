import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class GetCart extends CartEvent {
  const GetCart();
}

class AddCartItem extends CartEvent {
  final CartItemEntity item;

  const AddCartItem({required this.item});

  @override
  List<Object?> get props => [item];
}

class RemoveCartItem extends CartEvent {
  final CartItemEntity item;

  const RemoveCartItem({required this.item});

  @override
  List<Object?> get props => [item];
}
