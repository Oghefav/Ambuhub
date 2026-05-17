import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  // final String id;
  final double totalPrice;
  final List<CartItemEntity> items;

  const CartEntity({
    // required this.id,
     required this.items, required this.totalPrice});

  @override
  List<Object?> get props => [ items];
}

class CartItemEntity extends Equatable {
  final ServiceEntity service;
  final int quantity;

  const CartItemEntity({required this.service, required this.quantity});

  @override
  List<Object?> get props => [service, quantity];
}