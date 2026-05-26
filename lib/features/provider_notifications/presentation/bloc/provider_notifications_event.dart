import 'package:equatable/equatable.dart';

abstract class ProviderNotificationsEvent extends Equatable {
  const ProviderNotificationsEvent();

  @override
  List<Object?> get props => [];
}

class GetProviderNotifications extends ProviderNotificationsEvent {
  const GetProviderNotifications();
}

class GetProviderUnreadNotificationCount extends ProviderNotificationsEvent {
  const GetProviderUnreadNotificationCount();
}

class MarkProviderNotificationRead extends ProviderNotificationsEvent {
  final String notificationId;

  const MarkProviderNotificationRead({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class MarkAllProviderNotificationsRead extends ProviderNotificationsEvent {
  const MarkAllProviderNotificationsRead();
}

class ProviderNotificationsReset extends ProviderNotificationsEvent {
  const ProviderNotificationsReset();
}
