import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  final List<OrderEntity> orders;
  final OrderEntity? order;
  final String? errorMessage;
  final bool hasLoaded;

  const OrderState({
    this.orders = const [],
    this.order,
    this.errorMessage,
    this.hasLoaded = false,
  });

  bool get isInitialLoad => !hasLoaded;

  @override
  List<Object?> get props => [orders, order, errorMessage, hasLoaded];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading({
    super.orders,
    super.order,
    super.hasLoaded,
  });
}

class OrdersLoaded extends OrderState {
  const OrdersLoaded({
    required super.orders,
    super.hasLoaded = true,
  });
}
class OrderCreated extends OrderState {
  const OrderCreated({
    required super.order,
    super.orders,
    super.hasLoaded = true,
  });
}

class OrderCreatedFailure extends OrderState {
  const OrderCreatedFailure({
    required super.errorMessage,
    super.orders,
    super.hasLoaded = true,
  });
}
class OrderDetailLoading extends OrderState {
  const OrderDetailLoading({
    super.orders,
    super.order,
    super.hasLoaded,
  });
}

class OrderDetailLoaded extends OrderState {
  const OrderDetailLoaded({
    required super.order,
    super.orders,
    super.hasLoaded = true,
  });
}

class OrderDetailFailure extends OrderState {
  const OrderDetailFailure({
    required super.errorMessage,
    super.orders,
    super.order,
    super.hasLoaded = true,
  });
}

class OrderFailure extends OrderState {
  const OrderFailure({
    required super.errorMessage,
    super.orders,
    super.order,
    super.hasLoaded,
  });
}
