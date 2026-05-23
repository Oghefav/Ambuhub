import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);

  Future<Response<dynamic>> signUp(Map<String, dynamic> data) {
    return _dio.post('/auth/register', data: data);
  }

  Future<Response<dynamic>> logIn(Map<String, dynamic> data) {
    return _dio.post('/auth/login', data: data);
  }

  Future<Response<dynamic>> resetPassword(Map<String, dynamic> data) {
    return _dio.post('/auth/forgot-password', data: data);
  }

  Future<Response<dynamic>> updateProfile(Map<String, dynamic> data) {
    return _dio.patch('/auth/me', data: data);
  }

  Future<Response<dynamic>> changePassword(Map<String, dynamic> data) {
    return _dio.post('/auth/change-password', data: data);
  }
}
