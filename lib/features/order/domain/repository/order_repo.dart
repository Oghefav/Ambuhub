import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/booking/domain/entities/booking_checkout_params.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';

abstract class OrderRepo {
  Future<DataState<List<OrderEntity>>> getOrders();

  Future<DataState<OrderEntity>> getOrderById(String orderId);

  Future<DataState<OrderEntity>> hireCheckout(HireParams params);

  Future<DataState<OrderEntity>> cartCheckout();

  Future<DataState<OrderEntity>> bookingCheckout(BookingCheckoutParams params);
}
