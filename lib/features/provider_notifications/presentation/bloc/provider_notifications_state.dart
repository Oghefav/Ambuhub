import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProviderNotificationsState extends Equatable {
  final List<ProviderNotificationEntity> notifications;
  final int unreadCount;
  final String? errorMessage;
  final bool hasLoaded;
  final bool isLoadingList;
  final bool isLoadingCount;
  final bool isMarkingRead;

  const ProviderNotificationsState({
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

class ProviderNotificationsInitial extends ProviderNotificationsState {
  const ProviderNotificationsInitial();
}

class ProviderNotificationsLoaded extends ProviderNotificationsState {
  const ProviderNotificationsLoaded({
    super.notifications,
    super.unreadCount,
    super.errorMessage,
    super.hasLoaded,
    super.isLoadingList,
    super.isLoadingCount,
    super.isMarkingRead,
  });
}

class ProviderNotificationsFailure extends ProviderNotificationsState {
  const ProviderNotificationsFailure({
    required super.errorMessage,
    super.notifications,
    super.unreadCount,
    super.hasLoaded,
    super.isLoadingList,
    super.isLoadingCount,
    super.isMarkingRead,
  });
}
