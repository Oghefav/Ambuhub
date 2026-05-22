import 'package:ambuhub/features/reviews/domain/entities/write_review_params.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class GetAwaitingReviews extends ReviewEvent {
  const GetAwaitingReviews();
}

class GetWrittenReviews extends ReviewEvent {
  const GetWrittenReviews();
}

class WriteReview extends ReviewEvent {
  final WriteReviewParams params;

  const WriteReview({required this.params});

  @override
  List<Object?> get props => [params];
}

class GetReviewById extends ReviewEvent {
  final String reviewId;

  const GetReviewById({required this.reviewId});

  @override
  List<Object?> get props => [reviewId];
}

class ReviewReset extends ReviewEvent {
  const ReviewReset();
}
