import 'package:dio/dio.dart';

class BookingApiService {
  final Dio _dio;

  BookingApiService(this._dio);

  Future<Response<dynamic>> getProviderHireBookings() {
    return _dio.get('/orders/provider/hire-bookings');
  }
}
