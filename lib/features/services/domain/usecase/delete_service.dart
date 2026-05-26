import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class DeleteServiceUsecase implements Usecase<DataState<void>, String> {
  final ServiceRepo _serviceRepo;

  const DeleteServiceUsecase(this._serviceRepo);

  @override
  Future<DataState<void>> call({String? params}) {
    return _serviceRepo.deleteService(params!);
  }
}
