import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/reset_password.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final ClientSignUpUsecase _clientSignUpUsecase;
  final ServiceProviderSignUpUsecase _serviceProviderSignUpUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  AuthBloc(
    this._loginUsecase,
    this._clientSignUpUsecase,
    this._serviceProviderSignUpUsecase,
    this._resetPasswordUsecase
  ) : super(const AuthInitial()) {
    on<Login>(_onLogin);
    on<ClientSignUp>(_onClientSignUp);
    on<ServiceProviderSignUp>(_onServiceProviderSignUp);
    on<ResetPassword>(_onResetPassword);
    on<AuthReset>(_onAuthReset);
  }

  Future<void> _onLogin(Login login, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final dataState = await _loginUsecase(params: login.loginParams);

    if (dataState is DataSuccess) {
      emit(AuthSuccess(data: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.errorMessage));
    }
  }

  Future<void> _onClientSignUp(
    ClientSignUp clientSignUp,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final dataState = await _clientSignUpUsecase(
      params: clientSignUp.clientSignUpParams,
    );

    if (dataState is DataSuccess) {
      emit(AuthSuccess(data: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.errorMessage));
    }
  }

  Future<void> _onServiceProviderSignUp(
    ServiceProviderSignUp serviceProviderSignUp,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final dataState = await _serviceProviderSignUpUsecase(
      params: serviceProviderSignUp.serviceProviderSignUpParams,
    );

    if (dataState is DataSuccess) {
      emit(AuthSuccess(data: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.errorMessage));
    }
  }

  void _onAuthReset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }

  Future<void> _onResetPassword(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final dataState = await _resetPasswordUsecase(
      params: event.resetPasswordParams,
    );

    if (dataState is DataSuccess) {
      emit(AuthSuccess(data: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.errorMessage));
    }
  }
}
