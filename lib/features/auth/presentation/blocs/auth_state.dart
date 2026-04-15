import 'package:ambuhub/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? error;
  final UserEntity? user;
  const AuthState({this.error, this.user});

  @override
  List<Object?> get props => [error, user];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required super.user});
}

class AuthFailed extends AuthState {
  const AuthFailed({required super.error});
}
