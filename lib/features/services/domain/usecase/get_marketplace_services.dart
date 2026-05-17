import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class GetMarketplaceServicesUsecase
    implements Usecase<DataState<List<ServiceEntity>>, String> {
  final ServiceRepo _serviceRepo;
  const GetMarketplaceServicesUsecase(this._serviceRepo);

  @override
  Future<DataState<List<ServiceEntity>>> call({String? params}) {
    return _serviceRepo.getMarketplaceServices(params!);
  }
}
