import 'package:equatable/equatable.dart';

abstract class ServiceReviewsEvent extends Equatable {
  const ServiceReviewsEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceReviews extends ServiceReviewsEvent {
  final String serviceId;

  const GetServiceReviews({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}
