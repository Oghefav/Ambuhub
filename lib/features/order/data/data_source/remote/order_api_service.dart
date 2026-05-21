import 'package:dio/dio.dart';

class OrderApiService {
  final Dio _dio;

  OrderApiService(this._dio);

  Future<Response<dynamic>> createHireOrder(Map<String, dynamic> data) {
    return _dio.post('orders/hire-checkout/simulate-paystack', data: data);
  }
}
