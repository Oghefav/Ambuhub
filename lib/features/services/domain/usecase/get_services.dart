import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class GetServicesUsecase
    implements Usecase<DataState<List<ServiceEntity>>, void> {
  final ServiceRepo _serviceRepo;
  const GetServicesUsecase(this._serviceRepo);
  @override
  Future<DataState<List<ServiceEntity>>> call({void params}) {
    return _serviceRepo.getServices();
  }
}
