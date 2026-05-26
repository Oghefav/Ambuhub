import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';

abstract class ProviderNotificationsRepo {
  Future<DataState<List<ProviderNotificationEntity>>> getNotifications();

  Future<DataState<int>> getUnreadCount();

  Future<DataState<ProviderNotificationEntity?>> markAsRead(
    String notificationId,
  );

  Future<DataState<void>> markAllAsRead();
}
