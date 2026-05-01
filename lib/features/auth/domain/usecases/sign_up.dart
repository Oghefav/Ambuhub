import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';

class ClientSignUpUsecase implements Usecase<DataState<ClientEntity>, ClientSignUpParams> {
  final AuthRepository _authRepository;
  const ClientSignUpUsecase(this._authRepository);

  @override
  Future<DataState<ClientEntity>> call({ClientSignUpParams? params}) {
    return _authRepository.signUpClient(params!);
  }
}

class ServiceProviderSignUpUsecase implements Usecase<DataState<ServiceProviderEntity>, ServiceProviderSignUpParams> {
  final AuthRepository _authRepository;
  const ServiceProviderSignUpUsecase(this._authRepository);

  @override
  Future<DataState<ServiceProviderEntity>> call({ServiceProviderSignUpParams? params}) {
    return _authRepository.signUpServiceProvider(params!);
  }
}
