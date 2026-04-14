import 'package:ambuhub/features/auth/domain/entities/login_params.dart';

class LoginModel extends LoginParams {
  const LoginModel({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginModel.fromParams(LoginParams params) {
    return LoginModel(email: params.email, password: params.password);
  }
}
