import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/reviews/domain/entities/write_review_params.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';

abstract class ReviewRepo {
  Future<DataState<List<AwaitingReviewEntity>>> getAwaitingReviews();
  Future<DataState<List<WrittenReviewEntity>>> getWrittenReviews();
  Future<DataState<WrittenReviewEntity>> writeReview(WriteReviewParams params);
  Future<DataState<WrittenReviewEntity>> getReviewById(String reviewId);
  Future<DataState<ServiceReviewsEntity>> getServiceReviews(String serviceId);
}
