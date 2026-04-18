import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class AddServiceUsecase implements Usecase<DataState<ServiceEntity>, ServiceParams> {
  final ServiceRepo _serviceRepo;
  const AddServiceUsecase(this._serviceRepo);

  @override
  Future<DataState<ServiceEntity>> call({ServiceParams? params}) {
    return _serviceRepo.addService(params!);
  }
}
