import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

class GetWrittenReviewsUsecase
    implements Usecase<DataState<List<WrittenReviewEntity>>, void> {
  final ReviewRepo _repo;

  const GetWrittenReviewsUsecase(this._repo);

  @override
  Future<DataState<List<WrittenReviewEntity>>> call({void params}) {
    return _repo.getWrittenReviews();
  }
}
