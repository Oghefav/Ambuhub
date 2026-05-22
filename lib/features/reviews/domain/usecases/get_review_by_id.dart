import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

class GetReviewByIdUsecase
    implements Usecase<DataState<WrittenReviewEntity>, String> {
  final ReviewRepo _repo;

  const GetReviewByIdUsecase(this._repo);

  @override
  Future<DataState<WrittenReviewEntity>> call({String? params}) {
    return _repo.getReviewById(params!);
  }
}
