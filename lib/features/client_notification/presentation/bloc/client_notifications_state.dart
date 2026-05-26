import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ClientNotificationsState extends Equatable {
  final List<ClientNotificationEntity> notifications;
  final int unreadCount;
  final String? errorMessage;
  final bool hasLoaded;
  final bool isLoadingList;
  final bool isLoadingCount;
  final bool isMarkingRead;

  const ClientNotificationsState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
    this.hasLoaded = false,
    this.isLoadingList = false,
    this.isLoadingCount = false,
    this.isMarkingRead = false,
  });

  @override
  List<Object?> get props => [
        notifications,
        unreadCount,
        errorMessage,
        hasLoaded,
        isLoadingList,
        isLoadingCount,
        isMarkingRead,
      ];
}

class ClientNotificationsInitial extends ClientNotificationsState {
  const ClientNotificationsInitial();
}

class ClientNotificationsLoaded extends ClientNotificationsState {
  const ClientNotificationsLoaded({
    super.notifications,
    super.unreadCount,
    super.errorMessage,
    super.hasLoaded,
    super.isLoadingList,
    super.isLoadingCount,
    super.isMarkingRead,
  });
}

class ClientNotificationsFailure extends ClientNotificationsState {
  const ClientNotificationsFailure({
    required super.errorMessage,
    super.notifications,
    super.unreadCount,
    super.hasLoaded,
    super.isLoadingList,
    super.isLoadingCount,
    super.isMarkingRead,
  });
}
