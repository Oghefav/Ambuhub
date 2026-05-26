import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/client_notification/domain/entities/client_notification_entity.dart';

class ClientNotificationModel extends ClientNotificationEntity {
  const ClientNotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.createdAt,
    super.reminderKind,
    super.orderId,
    super.serviceId,
    super.receiptNumber,
    super.deadlineAt,
    super.readAt,
  });

  factory ClientNotificationModel.fromJson(Map<String, dynamic> json) {
    return ClientNotificationModel(
      id: (json['_id'] ?? json['id']).toString(),
      type: json['type']?.toString() ?? '',
      reminderKind: json['reminderKind']?.toString(),
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      orderId: json['orderId']?.toString(),
      serviceId: json['serviceId']?.toString(),
      receiptNumber: json['receiptNumber']?.toString(),
      deadlineAt: tryParseDateTime(json['deadlineAt']),
      readAt: tryParseDateTime(json['readAt']),
      createdAt:
          tryParseDateTime(json['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
