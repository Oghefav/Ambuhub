import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:ambuhub/features/auth/data/model/login.dart';
import 'package:ambuhub/features/auth/data/model/reset_password.dart';
import 'package:ambuhub/features/auth/data/model/sign_up.dart';
import 'package:ambuhub/features/auth/data/model/user.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/reset_password_params.dart';
import 'package:ambuhub/features/auth/domain/entities/service_provider.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/client.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';
import 'package:dio/dio.dart';

class AuthRepoImplementation implements AuthRepository {
  final AuthApiService _authApiService;

  const AuthRepoImplementation(this._authApiService);

  @override
  Future<DataState<ClientEntity>> signUpClient(
    ClientSignUpParams params,
  ) async {
    final data = ClientSignUpModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.signUp(data.toJson());

      if (httpResponse.statusCode == 201) {
        final Map<String, dynamic> userData = httpResponse.data;
        final user = ClientModel.fromJson(userData['user']);
        return DataSuccess(data: user);
      } else {
        final dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e));
    }
  }

  @override
  Future<DataState<ServiceProviderEntity>> signUpServiceProvider(
    ServiceProviderSignUpParams params,
  ) async {
    final data = ServiceProviderSignUpModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.signUp(data.toJson());

      if (httpResponse.statusCode == 201) {
        final Map<String, dynamic> userData = httpResponse.data;
        final user = ServiceProviderModel.fromJson(userData['user']);
        return DataSuccess(data: user);
      } else {
        final dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e));
    }
  }

  @override
  Future<DataState<dynamic>> login(LoginParams params) async {
    final data = LoginModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.logIn(data.toJson());

      if (httpResponse.statusCode == 200) {
        final Map<String, dynamic> userData = httpResponse.data;
        print('userData: ${userData['user']['role']}');
        if (userData['user']['role'] == 'patient') {
          final user = ClientModel.fromJson(userData['user']);
          return DataSuccess(data: user);
        } else {
          final user = ServiceProviderModel.fromJson(userData['user']);
          return DataSuccess(data: user);
        }
      } else {
        final dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<String>> resetPassword(ResetPasswordParams params) async {
    final data = ResetPasswordModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.resetPassword(data.toJson());
      if (httpResponse.statusCode == 200) {
        final message = httpResponse.data['message'];
        return DataSuccess(data: message);
      } else {
        final dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
