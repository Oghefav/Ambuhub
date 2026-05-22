import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/favorite/domain/repository/favorite_repo.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';

class AddFavoriteUsecase implements Usecase<DataState<List<ServiceEntity>>, String> {
  final FavoriteRepo _repo;

  const AddFavoriteUsecase(this._repo);

  @override
  Future<DataState<List<ServiceEntity>>> call({String? params}) {
    return _repo.addFavorite(params!);
  }
}
