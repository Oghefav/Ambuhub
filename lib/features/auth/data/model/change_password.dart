import 'package:ambuhub/features/auth/domain/entities/change_password_params.dart';

class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordModel.fromParams(ChangePasswordParams params) {
    return ChangePasswordModel(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
