import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class GetMarketplaceServiceByIdUsecase
    implements Usecase<DataState<ServiceEntity>, String> {
  final ServiceRepo _serviceRepo;

  const GetMarketplaceServiceByIdUsecase(this._serviceRepo);

  @override
  Future<DataState<ServiceEntity>> call({String? params}) {
    return _serviceRepo.getMarketplaceServiceById(params!);
  }
}
