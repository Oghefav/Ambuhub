import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/services/data/model/service.dart';

class CartModel extends CartEntity {
  const CartModel({required super.items, required super.totalPrice});

  static double calculateTotalPrice(List<CartItemModel> items) {
    return items.fold<double>(
      0,
      (total, item) => total + (item.service.price ?? 0) * item.quantity,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return CartModel(
      items: items,
      totalPrice: calculateTotalPrice(items),
    );
  }
   
}


class CartItemModel extends CartItemEntity {
  const CartItemModel({required super.service, required super.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      service: ServiceModel.fromJson(json),
      quantity: json['quantity'],
    );
  }
}
