import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';

abstract class AuthEvent {
  final LoginParams? loginParams;
  final ClientSignUpParams? clientSignUpParams;
  final ServiceProviderSignUpParams? serviceProviderSignUpParams;

  const AuthEvent({
    this.loginParams,
    this.clientSignUpParams,
    this.serviceProviderSignUpParams,
  });
}

class Login extends AuthEvent {
  const Login({required super.loginParams});
}

class ClientSignUp extends AuthEvent {
  const ClientSignUp({required super.clientSignUpParams});
}

class ServiceProviderSignUp extends AuthEvent {
  const ServiceProviderSignUp({required super.serviceProviderSignUpParams});
}

class AuthReset extends AuthEvent {
  const AuthReset();
}
