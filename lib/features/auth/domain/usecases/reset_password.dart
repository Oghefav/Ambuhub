import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/reset_password_params.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class ResetPasswordUsecase implements Usecase<DataState<void>, ResetPasswordParams> {
  final AuthRepository _authRepository;
  const ResetPasswordUsecase(this._authRepository);

  @override
  Future<DataState<void>> call({ResetPasswordParams? params}) {
    return _authRepository.resetPassword(params!);
  }
}