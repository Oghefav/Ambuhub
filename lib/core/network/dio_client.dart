import 'package:ambuhub/core/constants/constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
