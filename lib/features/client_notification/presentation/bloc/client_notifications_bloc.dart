import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/get_client_notifications.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/get_client_unread_notification_count.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/mark_all_client_notifications_read.dart';
import 'package:ambuhub/features/client_notification/domain/usecases/mark_client_notification_read.dart';
import 'package:ambuhub/features/client_notification/presentation/bloc/client_notifications_event.dart';
import 'package:ambuhub/features/client_notification/presentation/bloc/client_notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientNotificationsBloc
    extends Bloc<ClientNotificationsEvent, ClientNotificationsState> {
  final GetClientNotificationsUsecase _getNotificationsUsecase;
  final GetClientUnreadNotificationCountUsecase _getUnreadCountUsecase;
  final MarkClientNotificationReadUsecase _markReadUsecase;
  final MarkAllClientNotificationsReadUsecase _markAllReadUsecase;

  ClientNotificationsBloc(
    this._getNotificationsUsecase,
    this._getUnreadCountUsecase,
    this._markReadUsecase,
    this._markAllReadUsecase,
  ) : super(const ClientNotificationsInitial()) {
    on<GetClientNotifications>(_onGetNotifications);
    on<GetClientUnreadNotificationCount>(_onGetUnreadCount);
    on<MarkClientNotificationRead>(_onMarkRead);
    on<MarkAllClientNotificationsRead>(_onMarkAllRead);
    on<ClientNotificationsReset>(_onReset);
  }

  void _onReset(
    ClientNotificationsReset event,
    Emitter<ClientNotificationsState> emit,
  ) {
    emit(const ClientNotificationsInitial());
  }

  Future<void> _onGetNotifications(
    GetClientNotifications event,
    Emitter<ClientNotificationsState> emit,
  ) async {
    emit(ClientNotificationsLoaded(
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
      isLoadingList: true,
    ));

    final dataState = await _getNotificationsUsecase();
    if (dataState is DataSuccess) {
      emit(ClientNotificationsLoaded(
        notifications: dataState.data ?? [],
        unreadCount: state.unreadCount,
        hasLoaded: true,
      ));
      return;
    }

    emit(ClientNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onGetUnreadCount(
    GetClientUnreadNotificationCount event,
    Emitter<ClientNotificationsState> emit,
  ) async {
    emit(ClientNotificationsLoaded(
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
      isLoadingCount: true,
    ));

    final dataState = await _getUnreadCountUsecase();
    if (dataState is DataSuccess) {
      emit(ClientNotificationsLoaded(
        notifications: state.notifications,
        unreadCount: dataState.data ?? 0,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ClientNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onMarkRead(
    MarkClientNotificationRead event,
    Emitter<ClientNotificationsState> emit,
  ) async {
    final id = event.notificationId;
    final optimistic = _markReadLocally(state.notifications, id);
    final wasUnread = state.notifications.any((n) => n.id == id && !n.isRead);

    emit(ClientNotificationsLoaded(
      notifications: optimistic,
      unreadCount: wasUnread
          ? (state.unreadCount > 0 ? state.unreadCount - 1 : 0)
          : state.unreadCount,
      hasLoaded: state.hasLoaded,
      isMarkingRead: true,
    ));

    final dataState = await _markReadUsecase(params: id);
    if (dataState is DataSuccess) {
      final updated = dataState.data;
      final list = updated == null
          ? optimistic
          : optimistic
              .map((n) => n.id == updated.id ? updated : n)
              .toList();
      emit(ClientNotificationsLoaded(
        notifications: list,
        unreadCount: state.unreadCount,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ClientNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onMarkAllRead(
    MarkAllClientNotificationsRead event,
    Emitter<ClientNotificationsState> emit,
  ) async {
    final optimistic = state.notifications
        .map(
          (n) => ClientNotificationEntity(
            id: n.id,
            type: n.type,
            title: n.title,
            body: n.body,
            createdAt: n.createdAt,
            reminderKind: n.reminderKind,
            orderId: n.orderId,
            serviceId: n.serviceId,
            receiptNumber: n.receiptNumber,
            deadlineAt: n.deadlineAt,
            readAt: n.readAt ?? DateTime.now(),
          ),
        )
        .toList();

    emit(ClientNotificationsLoaded(
      notifications: optimistic,
      unreadCount: 0,
      hasLoaded: state.hasLoaded,
      isMarkingRead: true,
    ));

    final dataState = await _markAllReadUsecase();
    if (dataState is DataSuccess) {
      emit(ClientNotificationsLoaded(
        notifications: optimistic,
        unreadCount: 0,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ClientNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  List<ClientNotificationEntity> _markReadLocally(
    List<ClientNotificationEntity> list,
    String id,
  ) {
    return list
        .map(
          (n) => n.id == id
              ? ClientNotificationEntity(
                  id: n.id,
                  type: n.type,
                  title: n.title,
                  body: n.body,
                  createdAt: n.createdAt,
                  reminderKind: n.reminderKind,
                  orderId: n.orderId,
                  serviceId: n.serviceId,
                  receiptNumber: n.receiptNumber,
                  deadlineAt: n.deadlineAt,
                  readAt: n.readAt ?? DateTime.now(),
                )
              : n,
        )
        .toList();
  }
}
