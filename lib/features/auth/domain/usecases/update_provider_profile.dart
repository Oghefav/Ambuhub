import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/update_provider_profile_params.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class UpdateProviderProfileUsecase
    implements
        Usecase<DataState<ServiceProviderEntity>, UpdateProviderProfileParams> {
  final AuthRepository _authRepository;

  const UpdateProviderProfileUsecase(this._authRepository);

  @override
  Future<DataState<ServiceProviderEntity>> call({
    UpdateProviderProfileParams? params,
  }) {
    return _authRepository.updateProviderProfile(params!);
  }
}
