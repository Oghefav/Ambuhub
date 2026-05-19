import 'package:ambuhub/features/auth/domain/entities/reset_password_params.dart';

class ResetPasswordModel {
  final String email;
  final String newPassword;

  ResetPasswordModel({required this.email, required this.newPassword});

  factory ResetPasswordModel.fromParams(ResetPasswordParams params) {
    return ResetPasswordModel(
      email: params.email,
      newPassword: params.newPassword,
    );
  }
  Map<String, dynamic> toJson() {
    return {'email': email, 'newPassword': newPassword};
  }
}
