import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';

class GetServiceReviewsUsecase
    implements Usecase<DataState<ServiceReviewsEntity>, String> {
  final ReviewRepo _reviewRepo;

  const GetServiceReviewsUsecase(this._reviewRepo);

  @override
  Future<DataState<ServiceReviewsEntity>> call({String? params}) {
    return _reviewRepo.getServiceReviews(params!);
  }
}
