import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent({this.item});
  final CartItemEntity? item;

  @override
  List<Object?> get props => [item];
}

class GetCart extends CartEvent {
  const GetCart();
}

  class AddCartItem extends CartEvent {

  const AddCartItem({required super.item});
}

class RemoveCartItem extends CartEvent {
  const RemoveCartItem({required super.item});
}

class CartItemDecrement extends CartEvent {
  const CartItemDecrement({required super.item});
}

class CartItemIncrement extends CartEvent {
  const CartItemIncrement({required super.item});
}