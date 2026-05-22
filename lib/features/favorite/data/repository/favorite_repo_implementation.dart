import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/favorite/data/data_source/remote/favorites_api_service.dart';
import 'package:ambuhub/features/favorite/domain/repository/favorite_repo.dart';
import 'package:ambuhub/features/services/data/model/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:dio/dio.dart';

class FavoriteRepoImplementation implements FavoriteRepo {
  final FavoritesApiService _apiService;

  const FavoriteRepoImplementation(this._apiService);

  List<ServiceEntity> _parseServices(dynamic raw) {
    if (raw is! Map<String, dynamic>) return [];
    final data = raw['services'];
    if (data is! List) return [];
    return data.map((entry) {
      final map = Map<String, dynamic>.from(entry as Map);
      final nested = map['service'];
      final json = nested is Map
          ? Map<String, dynamic>.from(nested)
          : map;
      if (json['_id'] == null && json['id'] == null) {
        final id = map['serviceId'] ?? map['_id'];
        if (id != null) json['id'] = id.toString();
      }
      return ServiceModel.fromJson(json);
    }).toList();
  }

  @override
  Future<DataState<List<ServiceEntity>>> getFavorites() async {
    try {
      final httpResponse = await _apiService.getFavorites();

      if (httpResponse.statusCode == 200) {
        return DataSuccess(data: _parseServices(httpResponse.data));
      } else{
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(ErrorHandler.getErrorMessage(dioException), error: dioException);
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<List<ServiceEntity>>> addFavorite(String serviceId) async {
    try {
      final httpResponse = await _apiService.addFavorite(serviceId);
      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        return DataSuccess(data: _parseServices(httpResponse.data));
      } else{
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(ErrorHandler.getErrorMessage(dioException), error: dioException);
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<List<ServiceEntity>>> removeFavorite(String serviceId) async {
    try {
      final httpResponse = await _apiService.removeFavorite(serviceId);
      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
        return DataSuccess(data: _parseServices(httpResponse.data));
      } else{
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(ErrorHandler.getErrorMessage(dioException), error: dioException);
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  
}
