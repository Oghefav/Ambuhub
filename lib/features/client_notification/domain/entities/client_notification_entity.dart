import 'package:equatable/equatable.dart';

class ClientNotificationEntity extends Equatable {
  final String id;
  final String type;
  final String? reminderKind;
  final String title;
  final String body;
  final String? orderId;
  final String? serviceId;
  final String? receiptNumber;
  final DateTime? deadlineAt;
  final DateTime? readAt;
  final DateTime createdAt;

  const ClientNotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.reminderKind,
    this.orderId,
    this.serviceId,
    this.receiptNumber,
    this.deadlineAt,
    this.readAt,
  });

  bool get isRead => readAt != null;

  @override
  List<Object?> get props => [
        id,
        type,
        reminderKind,
        title,
        body,
        orderId,
        serviceId,
        receiptNumber,
        deadlineAt,
        readAt,
        createdAt,
      ];
}
