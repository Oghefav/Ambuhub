import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class MarketplaceServiceDetailState extends Equatable {
  const MarketplaceServiceDetailState();

  @override
  List<Object?> get props => [];
}

class MarketplaceServiceDetailInitial extends MarketplaceServiceDetailState {
  const MarketplaceServiceDetailInitial();
}

class MarketplaceServiceDetailLoading extends MarketplaceServiceDetailState {
  const MarketplaceServiceDetailLoading();
}

class MarketplaceServiceDetailReady extends MarketplaceServiceDetailState {
  final ServiceEntity service;
  final ServiceReviewsEntity serviceReviews;

  const MarketplaceServiceDetailReady({
    required this.service,
    required this.serviceReviews,
  });

  @override
  List<Object?> get props => [service, serviceReviews];
}

class MarketplaceServiceDetailFailure extends MarketplaceServiceDetailState {
  final String errorMessage;

  const MarketplaceServiceDetailFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
