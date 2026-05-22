import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/favorite/domain/repository/favorite_repo.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';

class GetFavoritesUsecase implements Usecase<DataState<List<ServiceEntity>>, void> {
  final FavoriteRepo _repo;

  const GetFavoritesUsecase(this._repo);

  @override
  Future<DataState<List<ServiceEntity>>> call({void params}) {
    return _repo.getFavorites();
  }
}
