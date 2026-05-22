import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';

class AwaitingReviewModel extends AwaitingReviewEntity {
  const AwaitingReviewModel({
    required super.orderId,
    required super.serviceId,
    required super.receiptNumber,
    required super.serviceTitle,
    required super.categorySlug,
    required super.lineKind,
    super.paidAt,
    super.hireEnd,
  });

  factory AwaitingReviewModel.fromJson(Map<String, dynamic> json) {
    return AwaitingReviewModel(
      orderId: json['orderId']?.toString() ?? '',
      serviceId: json['serviceId']?.toString() ?? '',
      receiptNumber: json['receiptNumber']?.toString() ?? '',
      serviceTitle: json['serviceTitle']?.toString() ?? '',
      categorySlug: json['categorySlug']?.toString() ?? '',
      lineKind: json['lineKind']?.toString() ?? '',
      paidAt: tryParseDateTime(json['paidAt']),
      hireEnd: tryParseDateTime(json['hireEnd']),
    );
  }
}
