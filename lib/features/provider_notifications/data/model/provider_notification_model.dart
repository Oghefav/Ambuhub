import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/provider_notifications/domain/entities/provider_notification_entity.dart';

class ProviderNotificationModel extends ProviderNotificationEntity {
  const ProviderNotificationModel({
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

  factory ProviderNotificationModel.fromJson(Map<String, dynamic> json) {
    return ProviderNotificationModel(
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        if (reminderKind != null) 'reminderKind': reminderKind,
        'title': title,
        'body': body,
        if (orderId != null) 'orderId': orderId,
        if (serviceId != null) 'serviceId': serviceId,
        if (receiptNumber != null) 'receiptNumber': receiptNumber,
        if (deadlineAt != null) 'deadlineAt': deadlineAt!.toUtc().toIso8601String(),
        if (readAt != null) 'readAt': readAt!.toUtc().toIso8601String(),
        'createdAt': createdAt.toUtc().toIso8601String(),
      };
}
