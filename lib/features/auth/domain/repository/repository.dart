import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> login(LoginParams params);

  Future<DataState<UserEntity>> signUp(SignUpParams params);
}
