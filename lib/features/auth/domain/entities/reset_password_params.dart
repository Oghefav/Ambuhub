import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordParams({
    required this.email, required this.newPassword, required this.confirmPassword
  });

  @override
  List<Object?> get props => [email, newPassword, confirmPassword];
}