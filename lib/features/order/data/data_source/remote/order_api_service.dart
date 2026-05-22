import 'package:dio/dio.dart';

class OrderApiService {
  final Dio _dio;

  OrderApiService(this._dio);

  Future<Response<dynamic>> getOrders() {
    return _dio.get('/orders/me');
  }

  Future<Response<dynamic>> getOrderById(String orderId) {
    return _dio.get('/orders/me/$orderId');
  }

  Future<Response<dynamic>> hireCheckout(
    Map<String, dynamic> data,
  ) {
    return _dio.post('/orders/hire-checkout/simulate-paystack', data: data);
  }

  Future<Response<dynamic>> cartCheckout(
  ) {
    return _dio.post('/orders/checkout/simulate-paystack');
  }

  Future<Response<dynamic>> bookingCheckout(
    Map<String, dynamic> data,
  ) {
    return _dio.post('/orders/booking-checkout/simulate-paystack', data: data);
  }
}
