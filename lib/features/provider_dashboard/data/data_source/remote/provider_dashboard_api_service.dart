import 'package:dio/dio.dart';

class ProviderDashboardApiService {
  final Dio _dio;

  ProviderDashboardApiService(this._dio);

  Future<Response<dynamic>> getWallet() {
    return _dio.get('/wallet/me');
  }

  Future<Response<dynamic>> getSalesByMonth({required int year}) {
    return _dio.get(
      '/orders/provider/sales-by-month',
      queryParameters: {'year': year},
    );
  }
}
