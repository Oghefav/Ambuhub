import 'package:ambuhub/features/reviews/domain/entities/service_review_summary.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:equatable/equatable.dart';

class ServiceReviewsEntity extends Equatable {
  final ServiceReviewSummaryEntity summary;
  final List<WrittenReviewEntity> reviews;

  const ServiceReviewsEntity({
    required this.summary,
    required this.reviews,
  });

  bool get hasDisplayableReviews =>
      summary.reviewCount > 0 || reviews.isNotEmpty;

  double get displayAverageRating {
    if (summary.averageRating > 0) return summary.averageRating;
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }

  int get displayReviewCount =>
      summary.reviewCount > 0 ? summary.reviewCount : reviews.length;

  @override
  List<Object?> get props => [summary, reviews];
}
