import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';

class WrittenReviewModel extends WrittenReviewEntity {
  const WrittenReviewModel({
    required super.id,
    required super.serviceId,
    required super.orderId,
    required super.rating,
    required super.body,
    required super.serviceTitle,
    required super.categorySlug,
    required super.lineKind,
    required super.reviewerDisplayName,
    super.createdAt,
  });

  factory WrittenReviewModel.fromJson(Map<String, dynamic> json) {
    return WrittenReviewModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      serviceId: json['serviceId']?.toString() ?? '',
      orderId: json['orderId']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      body: json['body']?.toString() ?? '',
      serviceTitle: json['serviceTitle']?.toString() ?? '',
      categorySlug: json['categorySlug']?.toString() ?? '',
      lineKind: json['lineKind']?.toString() ?? '',
      reviewerDisplayName: json['reviewerDisplayName']?.toString() ?? '',
      createdAt: tryParseDateTime(json['createdAt']),
    );
  }
}
