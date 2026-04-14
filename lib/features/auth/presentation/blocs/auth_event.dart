import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';

abstract class AuthEvent {
  final LoginParams? loginParams;
  final SignUpParams? signUpParams;

  const AuthEvent({
    this.loginParams,
    this.signUpParams
  });
}

class Login extends AuthEvent {
  const Login({required super.loginParams});
}

class SignUp extends AuthEvent {
  const SignUp({
    required super.signUpParams
  });
}
