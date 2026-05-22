import 'package:ambuhub/features/reviews/data/model/service_review_summary_model.dart';
import 'package:ambuhub/features/reviews/data/model/written_review_model.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';

class ServiceReviewsModel extends ServiceReviewsEntity {
  const ServiceReviewsModel({
    required super.summary,
    required super.reviews,
  });

  factory ServiceReviewsModel.fromJson(Map<String, dynamic> json) {
    final root = _unwrapRoot(json);
    final reviews = _parseReviewsList(root);
    final summary = _parseSummary(root['summary'], reviews);

    return ServiceReviewsModel(
      summary: summary,
      reviews: reviews,
    );
  }

  static Map<String, dynamic> _unwrapRoot(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return data;
    return json;
  }

  static List<WrittenReviewModel> _parseReviewsList(Map<String, dynamic> root) {
    for (final key in const ['reviews', 'items', 'writtenReviews']) {
      final raw = root[key];
      if (raw is List) {
        return raw
            .whereType<Map<String, dynamic>>()
            .map(WrittenReviewModel.fromJson)
            .toList();
      }
    }
    return const [];
  }

  static ServiceReviewSummaryModel _parseSummary(
    dynamic summaryRaw,
    List<WrittenReviewModel> reviews,
  ) {
    if (summaryRaw is Map<String, dynamic>) {
      final parsed = ServiceReviewSummaryModel.fromJson(summaryRaw);
      if (parsed.reviewCount > 0 || reviews.isEmpty) {
        return parsed.averageRating > 0 || reviews.isEmpty
            ? parsed
            : ServiceReviewSummaryModel(
                averageRating: _averageFromReviews(reviews),
                reviewCount: parsed.reviewCount > 0
                    ? parsed.reviewCount
                    : reviews.length,
              );
      }
    }

    if (reviews.isEmpty) {
      return const ServiceReviewSummaryModel(averageRating: 0, reviewCount: 0);
    }

    return ServiceReviewSummaryModel(
      averageRating: _averageFromReviews(reviews),
      reviewCount: reviews.length,
    );
  }

  static double _averageFromReviews(List<WrittenReviewModel> reviews) {
    final total = reviews.fold<int>(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }
}
