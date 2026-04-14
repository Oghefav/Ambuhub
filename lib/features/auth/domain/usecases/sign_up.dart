import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/user.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class SignUpUsecase implements Usecase<DataState<UserEntity>, SignUpParams> {
  final AuthRepository _authRepository;
  const SignUpUsecase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call({SignUpParams? params}) {
    return _authRepository.signUp(params!);
  }
}
