import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final SignUpUsecase _signUpUsecase;
  AuthBloc(this._loginUsecase, this._signUpUsecase)
    : super(const AuthInitial()) {
    on<Login>(onLogin);
    on<SignUp>(onSignUp);
  }

  void onLogin(Login login, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final dataState = await _loginUsecase(params: login.loginParams);

    if (dataState is DataSuccess) {
      emit(AuthSuccess(user: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.error));
    }
  }
  void onSignUp(SignUp signUp, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final dataState = await _signUpUsecase(params: signUp.signUpParams);

    if (dataState is DataSuccess) {
      emit(AuthSuccess(user: dataState.data));
    } else {
      emit(AuthFailed(error: dataState.error));
    }
  }
}
