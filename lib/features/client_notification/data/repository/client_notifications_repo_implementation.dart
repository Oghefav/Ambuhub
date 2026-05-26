import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/core/utililty/notification_api_response.dart';
import 'package:ambuhub/features/client_notification/data/data_source/remote/client_notifications_api_service.dart';
import 'package:ambuhub/features/client_notification/data/model/client_notification_model.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';
import 'package:ambuhub/features/client_notification/domain/repository/client_notifications_repo.dart';
import 'package:dio/dio.dart';

class ClientNotificationsRepoImplementation implements ClientNotificationsRepo {
  final ClientNotificationsApiService _apiService;

  const ClientNotificationsRepoImplementation(this._apiService);

  bool _isSuccess(int? code) =>
      code == 200 || code == 201 || code == 204;

  List<ClientNotificationEntity> _parseList(dynamic raw) {
    return parseNotificationList(raw)
        .map(ClientNotificationModel.fromJson)
        .toList();
  }

  ClientNotificationEntity _parseOne(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final nested = raw['notification'];
      if (nested is Map<String, dynamic>) {
        return ClientNotificationModel.fromJson(nested);
      }
      return ClientNotificationModel.fromJson(raw);
    }
    throw const FormatException('Invalid notification response');
  }

  @override
  Future<DataState<List<ClientNotificationEntity>>> getNotifications() async {
    try {
      final response = await _apiService.getNotifications();
      if (_isSuccess(response.statusCode)) {
        return DataSuccess(data: _parseList(response.data));
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<int>> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();
      if (_isSuccess(response.statusCode)) {
        return DataSuccess(data: parseUnreadNotificationCount(response.data));
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<ClientNotificationEntity?>> markAsRead(
    String notificationId,
  ) async {
    try {
      final response = await _apiService.markAsRead(notificationId);
      if (_isSuccess(response.statusCode)) {
        final data = response.data;
        if (data == null || data == '') {
          return const DataSuccess(data: null);
        }
        return DataSuccess(data: _parseOne(data));
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<void>> markAllAsRead() async {
    try {
      final response = await _apiService.markAllAsRead();
      if (_isSuccess(response.statusCode)) {
        return const DataSuccess(data: null);
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
