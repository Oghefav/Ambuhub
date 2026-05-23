import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/domain/entities/change_password_params.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/reset_password_params.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/update_profile_params.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';

abstract class AuthRepository {
  Future<DataState<dynamic>> login(LoginParams params);

  Future<DataState<ClientEntity>> signUpClient(ClientSignUpParams params);
  Future<DataState<String>> resetPassword(ResetPasswordParams params);
  Future<DataState<ServiceProviderEntity>> signUpServiceProvider(
    ServiceProviderSignUpParams params,
  );
  Future<DataState<ClientEntity>> updateProfile(UpdateProfileParams params);
  Future<DataState<String>> changePassword(ChangePasswordParams params);
}
