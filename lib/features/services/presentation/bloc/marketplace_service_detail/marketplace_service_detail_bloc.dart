import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/reviews/domain/usecases/get_service_reviews.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/usecase/get_marketplace_service_by_id.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_event.dart';
import 'package:ambuhub/features/services/presentation/bloc/marketplace_service_detail/marketplace_service_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketplaceServiceDetailBloc
    extends Bloc<MarketplaceServiceDetailEvent, MarketplaceServiceDetailState> {
  final GetMarketplaceServiceByIdUsecase _getMarketplaceServiceByIdUsecase;
  final GetServiceReviewsUsecase _getServiceReviewsUsecase;

  MarketplaceServiceDetailBloc(
    this._getMarketplaceServiceByIdUsecase,
    this._getServiceReviewsUsecase,
  ) : super(const MarketplaceServiceDetailInitial()) {
    on<LoadMarketplaceServiceDetail>(_onLoad);
  }

  Future<void> _onLoad(
    LoadMarketplaceServiceDetail event,
    Emitter<MarketplaceServiceDetailState> emit,
  ) async {
    emit(const MarketplaceServiceDetailLoading());

    final results = await Future.wait([
      _getMarketplaceServiceByIdUsecase(params: event.serviceId),
      _getServiceReviewsUsecase(params: event.serviceId),
    ]);

    final serviceState = results[0] as DataState<ServiceEntity>;
    final reviewsState = results[1] as DataState<ServiceReviewsEntity>;

    if (serviceState is DataFailed) {
      emit(MarketplaceServiceDetailFailure(
        errorMessage: serviceState.errorMessage ?? 'Failed to load service',
      ));
      return;
    }

    if (reviewsState is DataFailed) {
      emit(MarketplaceServiceDetailFailure(
        errorMessage: reviewsState.errorMessage ?? 'Failed to load reviews',
      ));
      return;
    }

    final service = serviceState.data;
    final reviews = reviewsState.data;
    if (service == null || reviews == null) {
      emit(const MarketplaceServiceDetailFailure(
        errorMessage: 'Failed to load service details',
      ));
      return;
    }

    emit(MarketplaceServiceDetailReady(
      service: service,
      serviceReviews: reviews,
    ));
  }
}
