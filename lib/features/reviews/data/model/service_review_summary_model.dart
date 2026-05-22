import 'package:ambuhub/features/reviews/domain/entities/service_review_summary.dart';

class ServiceReviewSummaryModel extends ServiceReviewSummaryEntity {
  const ServiceReviewSummaryModel({
    required super.averageRating,
    required super.reviewCount,
  });

  factory ServiceReviewSummaryModel.fromJson(Map<String, dynamic> json) {
    return ServiceReviewSummaryModel(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ??
          (json['totalReviews'] as num?)?.toInt() ??
          (json['count'] as num?)?.toInt() ??
          0,
    );
  }
}
