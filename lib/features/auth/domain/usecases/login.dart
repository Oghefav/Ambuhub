import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/user.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class LoginUsecase implements Usecase<DataState<UserEntity>, LoginParams> {
  final AuthRepository _authRepository;

  const LoginUsecase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call({LoginParams? params}) {
    return _authRepository.login(params!);
  }
}
