import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/booking/domain/usecases/booking_checkout.dart';
import 'package:ambuhub/features/cart/domain/usecases/cart_checkout.dart';
import 'package:ambuhub/features/hire/domain/usecases/hire_checkout.dart';
import 'package:ambuhub/features/order/domain/usecases/get_order_by_id.dart';
import 'package:ambuhub/features/order/domain/usecases/get_orders.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUsecase _getOrdersUsecase;
  final GetOrderByIdUsecase _getOrderByIdUsecase;
  final CartCheckoutUsecase _checkoutCartUsecase;
  final BookingCheckoutUsecase _checkoutBookingUsecase;
  final HireCheckoutUsecase _checkoutHireUsecase;

  OrderBloc(
    this._getOrdersUsecase,
    this._getOrderByIdUsecase,
    this._checkoutCartUsecase,
    this._checkoutBookingUsecase,
    this._checkoutHireUsecase,
  ) : super(const OrderInitial()) {
    on<GetOrders>(_onGetOrders);
    on<GetOrderById>(_onGetOrderById);
    on<OrderReset>(_onOrderReset);
    on<CheckoutCart>(_onCheckoutCart);
    on<CheckoutBooking>(_onCheckoutBooking);
    on<CheckoutHire>(_onCheckoutHire);
  }

  Future<void> _onGetOrders(GetOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading(
      orders: state.orders,
      order: state.order,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _getOrdersUsecase();

    if (dataState is DataSuccess) {
      emit(OrdersLoaded(orders: dataState.data ?? []));
    } else {
      emit(
        OrderFailure(
          errorMessage: dataState.errorMessage,
          orders: state.orders,
          order: state.order,
          hasLoaded: true,
        ),
      );
    }
  }

  Future<void> _onGetOrderById(
    GetOrderById event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderDetailLoading(
      orders: state.orders,
      order: state.order,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _getOrderByIdUsecase(params: event.orderId);

    if (dataState is DataSuccess) {
      emit(OrderDetailLoaded(
        order: dataState.data!,
        orders: state.orders,
        hasLoaded: state.hasLoaded,
      ));
    } else {
      emit(
        OrderDetailFailure(
          errorMessage: dataState.errorMessage,
          orders: state.orders,
          order: state.order,
          hasLoaded: state.hasLoaded,
        ),
      );
    }
  }

  void _onOrderReset(OrderReset event, Emitter<OrderState> emit) {
    emit(const OrderInitial());
  }

  Future<void> _onCheckoutCart(
    CheckoutCart event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading(
      orders: state.orders,
      order: state.order,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _checkoutCartUsecase();
    if (dataState is DataSuccess) {
      emit(OrderCreated(
        order: dataState.data!,
        orders: state.orders,
      ));
    } else {
      emit(OrderCreatedFailure(
        errorMessage: dataState.errorMessage,
        orders: state.orders,
      ));
    }
  }

  Future<void> _onCheckoutBooking(
    CheckoutBooking event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading(
      orders: state.orders,
      order: state.order,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _checkoutBookingUsecase(params: event.params);
    if (dataState is DataSuccess) {
      emit(OrderCreated(
        order: dataState.data!,
        orders: state.orders,
      ));
    } else {
      emit(OrderCreatedFailure(
        errorMessage: dataState.errorMessage,
        orders: state.orders,
      ));
    }
  }

  Future<void> _onCheckoutHire(
    CheckoutHire event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading(
      orders: state.orders,
      order: state.order,
      hasLoaded: state.hasLoaded,
    ));
    final dataState = await _checkoutHireUsecase(params: event.params);
    if (dataState is DataSuccess) {
      emit(OrderCreated(
        order: dataState.data!,
        orders: state.orders,
      ));
    } else {
      emit(OrderCreatedFailure(
        errorMessage: dataState.errorMessage,
        orders: state.orders,
      ));
    }
  }
}
