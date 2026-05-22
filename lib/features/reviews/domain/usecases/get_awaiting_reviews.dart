import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

class GetAwaitingReviewsUsecase
    implements Usecase<DataState<List<AwaitingReviewEntity>>, void> {
  final ReviewRepo _repo;

  const GetAwaitingReviewsUsecase(this._repo);

  @override
  Future<DataState<List<AwaitingReviewEntity>>> call({void params}) {
    return _repo.getAwaitingReviews();
  }
}
