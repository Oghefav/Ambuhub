import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';

abstract class ClientNotificationsRepo {
  Future<DataState<List<ClientNotificationEntity>>> getNotifications();

  Future<DataState<int>> getUnreadCount();

  Future<DataState<ClientNotificationEntity?>> markAsRead(String notificationId);

  Future<DataState<void>> markAllAsRead();
}
