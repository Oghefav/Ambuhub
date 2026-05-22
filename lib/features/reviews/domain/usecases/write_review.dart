import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/reviews/domain/entities/write_review_params.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

class WriteReviewUsecase
    implements Usecase<DataState<WrittenReviewEntity>, WriteReviewParams> {
  final ReviewRepo _repo;

  const WriteReviewUsecase(this._repo);

  @override
  Future<DataState<WrittenReviewEntity>> call({WriteReviewParams? params}) {
    return _repo.writeReview(params!);
  }
}
