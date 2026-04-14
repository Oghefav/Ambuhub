import 'package:dio/dio.dart';

abstract class AuthApiService {

  Future<Response<dynamic>> signUp(Map<String, dynamic> data);

  Future<Response<dynamic>> logIn(Map<String, dynamic> data);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;

  AuthApiServiceImpl(this._dio);

  @override
  Future<Response<dynamic>> signUp(Map<String, dynamic> data) {
    return _dio.post('/auth/register', data: data);
  }

  @override
  Future<Response<dynamic>> logIn(Map<String, dynamic> data) {
    return _dio.post('/auth/login', data: data);
  }
}
