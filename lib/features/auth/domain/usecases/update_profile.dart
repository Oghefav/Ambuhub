import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/entities/update_profile_params.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class UpdateProfileUsecase
    implements Usecase<DataState<ClientEntity>, UpdateProfileParams> {
  final AuthRepository _authRepository;

  const UpdateProfileUsecase(this._authRepository);

  @override
  Future<DataState<ClientEntity>> call({UpdateProfileParams? params}) {
    return _authRepository.updateProfile(params!);
  }
}
