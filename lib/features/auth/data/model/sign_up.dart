import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';

class SignUpModel extends SignUpParams {
  const SignUpModel({
    required super.name,
    required super.email,
    required super.country,
    required super.password,
    required super.phone,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'country': country,
      'password': password,
    };
  }

  factory SignUpModel.fromParams(SignUpParams params) {
    return SignUpModel(
      name: params.name,
      email: params.email,
      phone: params.phone,
      country: params.country,
      password: params.password,
      role: params.role,
    );
  }
}
