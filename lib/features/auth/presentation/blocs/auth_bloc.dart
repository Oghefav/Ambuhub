import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/auth/data/model/user.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/usecases/change_password.dart';
import 'package:ambuhub/features/auth/domain/usecases/login.dart';
import 'package:ambuhub/features/auth/domain/usecases/reset_password.dart';
import 'package:ambuhub/features/auth/domain/usecases/sign_up.dart';
import 'package:ambuhub/features/auth/domain/usecases/update_profile.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_event.dart';
import 'package:ambuhub/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final ClientSignUpUsecase _clientSignUpUsecase;
  final ServiceProviderSignUpUsecase _serviceProviderSignUpUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;

  AuthBloc(
    this._loginUsecase,
    this._clientSignUpUsecase,
    this._serviceProviderSignUpUsecase,
    this._resetPasswordUsecase,
    this._updateProfileUsecase,
    this._changePasswordUsecase,
  ) : super(const AuthInitial()) {
    on<Login>(_onLogin);
    on<ClientSignUp>(_onClientSignUp);
    on<ServiceProviderSignUp>(_onServiceProviderSignUp);
    on<ResetPassword>(_onResetPassword);
    on<UpdateProfile>(_onUpdateProfile);
    on<ChangePassword>(_onChangePassword);
    on<AuthReset>(_onAuthReset);
  }

  ClientEntity? get _currentClient {
    final current = state;
    if (current is AuthSuccess && current.data is ClientEntity) {
      return current.data as ClientEntity;
    }
    return null;
  }

  (String? profileError, String? passwordError) _sectionErrorsFrom(
    AuthState state,
  ) {
    if (state is AuthSuccess) {
      return (state.profileError, state.passwordError);
    }
    return (null, null);
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

  bool get _isPasswordUpdating =>
      state is AuthSuccess && (state as AuthSuccess).isPasswordUpdating;

  bool get _isProfileUpdating =>
      state is AuthSuccess && (state as AuthSuccess).isProfileUpdating;

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<AuthState> emit,
  ) async {
    if (_isProfileUpdating) return;

    final previousClient = _currentClient;
    final (_, previousPasswordError) = _sectionErrorsFrom(state);
    if (previousClient == null) {
      emit(AuthFailed(error: 'Not signed in'));
      return;
    }

    emit(
      AuthSuccess(
        data: previousClient,
        isProfileUpdating: true,
        isPasswordUpdating: _isPasswordUpdating,
        passwordError: previousPasswordError,
      ),
    );

    final dataState = await _updateProfileUsecase(
      params: event.updateProfileParams,
    );

    if (dataState is DataSuccess) {
      final parsed = dataState.data as ClientModel;
      final params = event.updateProfileParams!;
      emit(
        AuthSuccess(
          data: parsed.mergedFromUpdate(
            submitted: params,
            previous: previousClient,
          ),
          profileError: null,
          passwordError: previousPasswordError,
          isPasswordUpdating: _isPasswordUpdating,
        ),
      );
    } else {
      emit(
        AuthSuccess(
          data: previousClient,
          profileError: dataState.errorMessage,
          passwordError: previousPasswordError,
          isPasswordUpdating: _isPasswordUpdating,
        ),
      );
    }
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<AuthState> emit,
  ) async {
    if (_isPasswordUpdating) return;

    final client = _currentClient;
    final (previousProfileError, _) = _sectionErrorsFrom(state);
    if (client == null) {
      emit(AuthFailed(error: 'Not signed in'));
      return;
    }

    emit(
      AuthSuccess(
        data: client,
        isPasswordUpdating: true,
        isProfileUpdating: _isProfileUpdating,
        profileError: previousProfileError,
      ),
    );

    final dataState = await _changePasswordUsecase(
      params: event.changePasswordParams,
    );

    if (dataState is DataSuccess) {
      emit(
        AuthSuccess(
          data: client,
          profileError: previousProfileError,
          passwordError: null,
          isProfileUpdating: _isProfileUpdating,
        ),
      );
    } else {
      emit(
        AuthSuccess(
          data: client,
          profileError: previousProfileError,
          passwordError: dataState.errorMessage,
          isProfileUpdating: _isProfileUpdating,
        ),
      );
    }
  }
}
