import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/change_password_params.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class ChangePasswordUsecase
    implements Usecase<DataState<String>, ChangePasswordParams> {
  final AuthRepository _authRepository;

  const ChangePasswordUsecase(this._authRepository);

  @override
  Future<DataState<String>> call({ChangePasswordParams? params}) {
    return _authRepository.changePassword(params!);
  }
}
