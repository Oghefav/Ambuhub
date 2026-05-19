import 'package:dio/dio.dart';

class CartApiService {
  final Dio _dio;
  CartApiService(this._dio);

  Future<Response<dynamic>> getCart() {
    return _dio.get('/cart');
  }

  Future<Response<dynamic>> addToCart(Map<String, dynamic> data) {
    return _dio.post('/cart/items', data: data);
  }

  Future<Response<dynamic>> removeFromCart(String itemId) {
    return _dio.delete('/cart/items/$itemId');
  }
  Future<Response<dynamic>> updateCartItem(Map<String, dynamic> data) {
    print('Data: ${data}');
    return _dio.patch('/cart/items/${data['serviceId']}', data: data);
  }

}
