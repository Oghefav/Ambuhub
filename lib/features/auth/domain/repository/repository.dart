import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';

abstract class AuthRepository {
  Future<DataState<dynamic>> login(LoginParams params);

  Future<DataState<ClientEntity>> signUpClient(ClientSignUpParams params);
  // Future<DataSta
  Future<DataState<ServiceProviderEntity>> signUpServiceProvider(ServiceProviderSignUpParams params);
}
