import 'package:equatable/equatable.dart';

class ServiceReviewSummaryEntity extends Equatable {
  final double averageRating;
  final int reviewCount;

  const ServiceReviewSummaryEntity({
    required this.averageRating,
    required this.reviewCount,
  });

  bool get hasReviews => reviewCount > 0;

  @override
  List<Object?> get props => [averageRating, reviewCount];
}
