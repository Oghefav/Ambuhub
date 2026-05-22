import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_service_reviews.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/service_reviews/service_reviews_event.dart';
import 'package:ambuhub/features/reviews/presentation/bloc/service_reviews/service_reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceReviewsBloc extends Bloc<ServiceReviewsEvent, ServiceReviewsState> {
  final GetServiceReviewsUsecase _getServiceReviewsUsecase;

  ServiceReviewsBloc(this._getServiceReviewsUsecase)
      : super(const ServiceReviewsInitial()) {
    on<GetServiceReviews>(_onGetServiceReviews);
  }

  Future<void> _onGetServiceReviews(
    GetServiceReviews event,
    Emitter<ServiceReviewsState> emit,
  ) async {
    emit(const ServiceReviewsLoading());

    final dataState = await _getServiceReviewsUsecase(params: event.serviceId);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(ServiceReviewsSuccess(data: dataState.data!));
      return;
    }

    emit(ServiceReviewsFailure(errorMessage: dataState.errorMessage));
  }
}
