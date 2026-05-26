import 'package:ambuhub/core/widgets/bordered_action_button.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_bloc.dart';
import 'package:ambuhub/features/provider_notifications/presentation/bloc/provider_notifications_event.dart';
import 'package:ambuhub/features/provider_notifications/presentation/ui/widgets/provider_notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderNotificationsList extends StatelessWidget {
  final List<ProviderNotificationEntity> notifications;
  final bool isMarkingAllRead;

  const ProviderNotificationsList({
    super.key,
    required this.notifications,
    this.isMarkingAllRead = false,
  });

  bool get _hasUnread => notifications.any((n) => !n.isRead);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_hasUnread)
          BorderedActionButton(
            label: 'Mark all as read',
            isLoading: isMarkingAllRead,
            onPressed: () {
              context.read<ProviderNotificationsBloc>().add(
                const MarkAllProviderNotificationsRead(),
              );
            },
          ),
        if (_hasUnread) SizedBox(height: 15.h),
        ...notifications.map(
          (notification) => ProviderNotificationCard(
            notification: notification,
            onMarkAsRead: notification.isRead
                ? null
                : () {
                    context.read<ProviderNotificationsBloc>().add(
                      MarkProviderNotificationRead(
                        notificationId: notification.id,
                      ),
                    );
                  },
          ),
        ),
      ],
    );
  }
}
