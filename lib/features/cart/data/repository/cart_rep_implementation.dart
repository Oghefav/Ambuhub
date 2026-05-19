import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/cart/data/data_source/remote/cart_api_service.dart';
import 'package:ambuhub/features/cart/data/model/cart.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';
import 'package:dio/dio.dart';

class CartRepoImplementation implements CartRepo {
  final CartApiService _cartApiService;
  const CartRepoImplementation(this._cartApiService);

  @override
  Future<DataState<CartEntity>> getCart() async {
    try {
      final httpResponse = await _cartApiService.getCart();
      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data['cart'];
        final cart = CartModel.fromJson(data);
        return DataSuccess(data: cart);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<CartEntity>> addToCart(CartItemEntity item) async {
    try {
      final data = {'serviceId': item.service.id, 'quantity': item.quantity};
      print('Data: ${data}');
      final httpResponse = await _cartApiService.addToCart(data);
      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data['cart'];
        final cart = CartModel.fromJson(data);
        return DataSuccess(data: cart);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<CartEntity>> changeCartItemQuantity(int quantity, String serviceId) async {
    try {
      final data = {'quantity': quantity,'serviceId': serviceId};
      final httpResponse = await _cartApiService.updateCartItem(
        data,
      );
      print('HttpResponse: ${httpResponse.data}');
      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data['cart'];
        final cart = CartModel.fromJson(data);
        return DataSuccess(data: cart);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<CartEntity>> removeFromCart(CartItemEntity item) async {
    try {
      final httpResponse = await _cartApiService.removeFromCart(
        item.service.id,
      );
      if (httpResponse.statusCode == 200) {
        final data = httpResponse.data['cart'];
        final cart = CartModel.fromJson(data);
        return DataSuccess(data: cart);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
