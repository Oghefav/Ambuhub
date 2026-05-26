import 'package:equatable/equatable.dart';

abstract class ClientNotificationsEvent extends Equatable {
  const ClientNotificationsEvent();

  @override
  List<Object?> get props => [];
}

class GetClientNotifications extends ClientNotificationsEvent {
  const GetClientNotifications();
}

class GetClientUnreadNotificationCount extends ClientNotificationsEvent {
  const GetClientUnreadNotificationCount();
}

class MarkClientNotificationRead extends ClientNotificationsEvent {
  final String notificationId;

  const MarkClientNotificationRead({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class MarkAllClientNotificationsRead extends ClientNotificationsEvent {
  const MarkAllClientNotificationsRead();
}

class ClientNotificationsReset extends ClientNotificationsEvent {
  const ClientNotificationsReset();
}
