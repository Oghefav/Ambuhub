import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? error;
  final dynamic data;
  const AuthState({this.error, this.data});

  @override
  List<Object?> get props => [error, data];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String? profileError;
  final String? passwordError;
  final bool isProfileUpdating;
  final bool isPasswordUpdating;

  const AuthSuccess({
    required super.data,
    super.error,
    this.profileError,
    this.passwordError,
    this.isProfileUpdating = false,
    this.isPasswordUpdating = false,
  });

  @override
  List<Object?> get props => [
        data,
        error,
        profileError,
        passwordError,
        isProfileUpdating,
        isPasswordUpdating,
      ];
}

class AuthFailed extends AuthState {
  const AuthFailed({required super.error});
}
