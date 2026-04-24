import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class GetServiceInfoUsecase
    implements Usecase<DataState<List<ServiceEntity>>, String> {
  final ServiceRepo _serviceRepo;
  GetServiceInfoUsecase(this._serviceRepo);

  @override
  Future<DataState<List<ServiceEntity>>> call({String? params}) async {
    return  await _serviceRepo.getServiceInfo(params!);
  }
}
