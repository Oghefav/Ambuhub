import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:ambuhub/features/auth/data/model/login.dart';
import 'package:ambuhub/features/auth/data/model/sign_up.dart';
import 'package:ambuhub/features/auth/data/model/user.dart';
import 'package:ambuhub/features/auth/domain/entities/login_params.dart';
import 'package:ambuhub/features/auth/domain/entities/sign_up_params.dart';
import 'package:ambuhub/features/auth/domain/entities/user.dart';
import 'package:ambuhub/features/auth/domain/repository/repository.dart';
import 'package:dio/dio.dart';

class AuthRepoImplementation implements AuthRepository {
  final AuthApiService _authApiService;

  const AuthRepoImplementation(this._authApiService);

  @override
  Future<DataState<UserEntity>> signUp(SignUpParams params) async {
    final data = SignUpModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.signUp(data.toJson());

      if (httpResponse.statusCode == 201) {
        final Map<String, dynamic> userData = httpResponse.data;

        final user = UserModel.fromJson(userData['user']);
        print(user.email);
        return DataSuccess(data: user);
      } else {
        print(' the error ${httpResponse.data['message']}');
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
      print('the erroe $e');
      return DataFailed(ErrorHandler.getErrorMessage(e));
    }
  }

  @override
  Future<DataState<UserEntity>> login(LoginParams params) async {
    final data = LoginModel.fromParams(params);
    try {
      final httpResponse = await _authApiService.logIn(data.toJson());

      if (httpResponse.statusCode == 200) {
        final Map<String, dynamic> userData = httpResponse.data;

        final user = UserModel.fromJson(userData['user']);
        print(user.email);
        return DataSuccess(data: user);
      } else {
        print(httpResponse.data['message']);

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
      print(e);
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
