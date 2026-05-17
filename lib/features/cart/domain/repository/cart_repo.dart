import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';

abstract class CartRepo {
  Future<DataState<CartEntity>> addToCart(CartItemEntity item);
  Future<DataState<CartEntity>> getCart();
  Future<DataState<CartEntity>> removeFromCart(CartItemEntity item);
}