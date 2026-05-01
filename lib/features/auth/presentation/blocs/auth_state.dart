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
  const AuthSuccess({super.data});
}

class AuthFailed extends AuthState {
  const AuthFailed({required super.error});
}
