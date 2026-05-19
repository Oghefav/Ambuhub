import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String newPassword;

  const ResetPasswordParams({
    required this.email, required this.newPassword,
  });

  @override
  List<Object?> get props => [email, newPassword,];
}