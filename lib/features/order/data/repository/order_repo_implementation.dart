import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/booking/domain/entities/booking_checkout_params.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/order/data/data_source/remote/order_api_service.dart';
import 'package:ambuhub/features/order/data/model/order_model.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';
import 'package:dio/dio.dart';

class OrderRepoImplementation implements OrderRepo {
  final OrderApiService _apiService;

  const OrderRepoImplementation(this._apiService);

  @override
  Future<DataState<List<OrderEntity>>> getOrders() async {
    try {
      final httpResponse = await _apiService.getOrders();

      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data;
        if (data is Map<String, dynamic>) {
          return DataSuccess(data: _parseOrderList(data));
        }
        if (data is List) {
          return DataSuccess(
            data: data
                .whereType<Map<String, dynamic>>()
                .map(OrderModel.fromJson)
                .toList(),
          );
        }
        return _badResponse(httpResponse);
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<OrderEntity>> getOrderById(String orderId) async {
    try {
      final httpResponse = await _apiService.getOrderById(orderId);

      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data;
        if (data is Map<String, dynamic>) {
          return DataSuccess(data: OrderModel.fromJson(data));
        }
        return _badResponse(httpResponse);
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<OrderEntity>> hireCheckout(HireParams params) async {
    return _postCheckout(
      () => _apiService.hireCheckout(params.toJson()),
      OrderModel.fromJson,
    );
  }

  @override
  Future<DataState<OrderEntity>> cartCheckout() async {
    return _postCheckout(
      () => _apiService.cartCheckout(),
      OrderModel.fromJson,
    );
  }

  @override
  Future<DataState<OrderEntity>> bookingCheckout(
    BookingCheckoutParams params,
  ) async {
    return _postCheckout(
      () => _apiService.bookingCheckout(params.toJson()),
      OrderModel.fromJson,
    );
  }

  Future<DataState<OrderEntity>> _postCheckout(
    Future<Response<dynamic>> Function() request,
    OrderEntity Function(Map<String, dynamic> json) parse,
  ) async {
    try {
      final httpResponse = await request();

      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        final data = httpResponse.data;
        if (data is Map<String, dynamic>) {
          return DataSuccess(data: parse(data));
        }
        return _badResponse(httpResponse);
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  List<OrderEntity> _parseOrderList(Map<String, dynamic> data) {
    final raw = data['orders'] as List? ?? data['data'] as List? ?? [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(OrderModel.fromJson)
        .toList();
  }

  DataFailed<T> _badResponse<T>(Response<dynamic> httpResponse) {
    final dioException = DioException(
      requestOptions: httpResponse.requestOptions,
      error: httpResponse.statusMessage,
      type: DioExceptionType.badResponse,
    );
    return DataFailed(
      ErrorHandler.getErrorMessage(dioException),
      error: dioException,
    );
  }
}
