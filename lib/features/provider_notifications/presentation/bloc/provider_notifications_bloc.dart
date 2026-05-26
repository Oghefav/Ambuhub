import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/get_provider_notifications.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/get_provider_unread_notification_count.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/mark_all_provider_notifications_read.dart';
import 'package:ambuhub/features/provider_notifications/domain/usecases/mark_provider_notification_read.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_event.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderNotificationsBloc
    extends Bloc<ProviderNotificationsEvent, ProviderNotificationsState> {
  final GetProviderNotificationsUsecase _getNotificationsUsecase;
  final GetProviderUnreadNotificationCountUsecase _getUnreadCountUsecase;
  final MarkProviderNotificationReadUsecase _markReadUsecase;
  final MarkAllProviderNotificationsReadUsecase _markAllReadUsecase;

  ProviderNotificationsBloc(
    this._getNotificationsUsecase,
    this._getUnreadCountUsecase,
    this._markReadUsecase,
    this._markAllReadUsecase,
  ) : super(const ProviderNotificationsInitial()) {
    on<GetProviderNotifications>(_onGetNotifications);
    on<GetProviderUnreadNotificationCount>(_onGetUnreadCount);
    on<MarkProviderNotificationRead>(_onMarkRead);
    on<MarkAllProviderNotificationsRead>(_onMarkAllRead);
    on<ProviderNotificationsReset>(_onReset);
  }

  void _onReset(
    ProviderNotificationsReset event,
    Emitter<ProviderNotificationsState> emit,
  ) {
    emit(const ProviderNotificationsInitial());
  }

  Future<void> _onGetNotifications(
    GetProviderNotifications event,
    Emitter<ProviderNotificationsState> emit,
  ) async {
    emit(ProviderNotificationsLoaded(
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
      isLoadingList: true,
    ));

    final dataState = await _getNotificationsUsecase();
    if (dataState is DataSuccess) {
      emit(ProviderNotificationsLoaded(
        notifications: dataState.data ?? [],
        unreadCount: state.unreadCount,
        hasLoaded: true,
      ));
      return;
    }

    emit(ProviderNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onGetUnreadCount(
    GetProviderUnreadNotificationCount event,
    Emitter<ProviderNotificationsState> emit,
  ) async {
    emit(ProviderNotificationsLoaded(
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
      isLoadingCount: true,
    ));

    final dataState = await _getUnreadCountUsecase();
    if (dataState is DataSuccess) {
      emit(ProviderNotificationsLoaded(
        notifications: state.notifications,
        unreadCount: dataState.data ?? 0,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ProviderNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onMarkRead(
    MarkProviderNotificationRead event,
    Emitter<ProviderNotificationsState> emit,
  ) async {
    final id = event.notificationId;
    final optimistic = _markReadLocally(state.notifications, id);
    final wasUnread = state.notifications.any((n) => n.id == id && !n.isRead);

    emit(ProviderNotificationsLoaded(
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
      emit(ProviderNotificationsLoaded(
        notifications: list,
        unreadCount: state.unreadCount,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ProviderNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  Future<void> _onMarkAllRead(
    MarkAllProviderNotificationsRead event,
    Emitter<ProviderNotificationsState> emit,
  ) async {
    final optimistic = state.notifications
        .map(
          (n) => ProviderNotificationEntity(
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

    emit(ProviderNotificationsLoaded(
      notifications: optimistic,
      unreadCount: 0,
      hasLoaded: state.hasLoaded,
      isMarkingRead: true,
    ));

    final dataState = await _markAllReadUsecase();
    if (dataState is DataSuccess) {
      emit(ProviderNotificationsLoaded(
        notifications: optimistic,
        unreadCount: 0,
        hasLoaded: state.hasLoaded,
      ));
      return;
    }

    emit(ProviderNotificationsFailure(
      errorMessage: dataState.errorMessage,
      notifications: state.notifications,
      unreadCount: state.unreadCount,
      hasLoaded: state.hasLoaded,
    ));
  }

  List<ProviderNotificationEntity> _markReadLocally(
    List<ProviderNotificationEntity> list,
    String id,
  ) {
    return list
        .map(
          (n) => n.id == id
              ? ProviderNotificationEntity(
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
