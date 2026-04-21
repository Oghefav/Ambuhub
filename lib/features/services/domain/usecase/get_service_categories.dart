import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class GetServiceCategoriesUsecase
    implements Usecase<DataState<List<ServiceCategoryEntity>>, void> {
  final ServiceRepo _serviceRepo;
  const GetServiceCategoriesUsecase(this._serviceRepo);
  @override
  Future<DataState<List<ServiceCategoryEntity>>> call({void params}) {
    return _serviceRepo.getServiceCategories();
  }
}
