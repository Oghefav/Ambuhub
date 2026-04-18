import 'package:ambuhub/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioClient {
  final _cookieJar = CookieJar();
  late Dio _dio;
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  Dio get dio => _dio;
}
