import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/update_service_availability_params.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';

class UpdateServiceAvailabilityUsecase
    implements
        Usecase<DataState<ServiceEntity>, UpdateServiceAvailabilityParams> {
  final ServiceRepo _serviceRepo;

  const UpdateServiceAvailabilityUsecase(this._serviceRepo);

  @override
  Future<DataState<ServiceEntity>> call({
    UpdateServiceAvailabilityParams? params,
  }) {
    return _serviceRepo.updateServiceAvailability(params!);
  }
}
