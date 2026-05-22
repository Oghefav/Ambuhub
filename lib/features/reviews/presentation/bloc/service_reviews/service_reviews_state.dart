import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:equatable/equatable.dart';

abstract class ServiceReviewsState extends Equatable {
  const ServiceReviewsState();

  @override
  List<Object?> get props => [];
}

class ServiceReviewsInitial extends ServiceReviewsState {
  const ServiceReviewsInitial();
}

class ServiceReviewsLoading extends ServiceReviewsState {
  const ServiceReviewsLoading();
}

class ServiceReviewsSuccess extends ServiceReviewsState {
  final ServiceReviewsEntity data;

  const ServiceReviewsSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ServiceReviewsFailure extends ServiceReviewsState {
  final String? errorMessage;

  const ServiceReviewsFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
