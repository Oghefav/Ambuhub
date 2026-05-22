import 'package:equatable/equatable.dart';

/// Order line eligible for a client review (awaiting review).
class AwaitingReviewEntity extends Equatable {
  final String orderId;
  final String serviceId;
  final String receiptNumber;
  final String serviceTitle;
  final String categorySlug;
  final String lineKind;
  final DateTime? paidAt;
  final DateTime? hireEnd;

  const AwaitingReviewEntity({
    required this.orderId,
    required this.serviceId,
    required this.receiptNumber,
    required this.serviceTitle,
    required this.categorySlug,
    required this.lineKind,
    this.paidAt,
    this.hireEnd,
  });

  @override
  List<Object?> get props => [
        orderId,
        serviceId,
        receiptNumber,
        serviceTitle,
        categorySlug,
        lineKind,
        paidAt,
        hireEnd,
      ];
}
