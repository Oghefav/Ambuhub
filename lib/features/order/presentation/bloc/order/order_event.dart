import 'package:ambuhub/features/booking/domain/entities/booking_checkout_params.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class GetOrders extends OrderEvent {
  const GetOrders();
}

class GetOrderById extends OrderEvent {
  final String orderId;

  const GetOrderById({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
class CheckoutCart extends OrderEvent {
  const CheckoutCart();
}

class CheckoutBooking extends OrderEvent {
  final BookingCheckoutParams params;
  const CheckoutBooking({required this.params});
}

class CheckoutHire extends OrderEvent {
  final HireParams params;
  const CheckoutHire({required this.params});
}
class OrderReset extends OrderEvent {
  const OrderReset();
}
