import 'package:dio/dio.dart';

class ProviderNotificationsApiService {
  final Dio _dio;

  ProviderNotificationsApiService(this._dio);

  Future<Response<dynamic>> getNotifications() {
    return _dio.get('/notifications/me');
  }

  Future<Response<dynamic>> getUnreadCount() {
    return _dio.get('/notifications/me/unread-count');
  }

  Future<Response<dynamic>> markAsRead(String notificationId) {
    return _dio.patch('/notifications/me/$notificationId/read');
  }

  Future<Response<dynamic>> markAllAsRead() {
    return _dio.patch('/notifications/me/read-all');
  }
}
