import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';

abstract class FavoriteRepo {
  Future<DataState<List<ServiceEntity>>> getFavorites();
  Future<DataState<List<ServiceEntity>>> addFavorite(String serviceId);
  Future<DataState<List<ServiceEntity>>> removeFavorite(String serviceId);
}
