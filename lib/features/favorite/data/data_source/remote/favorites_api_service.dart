import 'package:dio/dio.dart';

class FavoritesApiService {
  final Dio _dio;

  FavoritesApiService(this._dio);

  Future<Response<dynamic>> getFavorites() {
    return _dio.get('/services/favorites/me');
  }

  Future<Response<dynamic>> addFavorite(String serviceId) {
    return _dio.post('/services/favorites/me', data: {'serviceId': serviceId});
  }

  Future<Response<dynamic>> removeFavorite(String serviceId) {
    return _dio.delete('/services/favorites/me/$serviceId');
  }
}
