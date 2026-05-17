import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class GetMarketplaceServicesState extends Equatable {
  final List<ServiceEntity>? services;
  final String? errorMessage;
  final String? categorySlug;

  const GetMarketplaceServicesState({
    this.services,
    this.errorMessage,
    this.categorySlug,
  });

  @override
  List<Object?> get props => [services, errorMessage, categorySlug];
}

class GetMarketplaceServicesInitial extends GetMarketplaceServicesState {
  const GetMarketplaceServicesInitial();
}

class GetMarketplaceServicesLoading extends GetMarketplaceServicesState {
  const GetMarketplaceServicesLoading();
}

class GetMarketplaceServicesSuccess extends GetMarketplaceServicesState {
  const GetMarketplaceServicesSuccess({
    required super.services,
    required super.categorySlug,
  });
}

class GetMarketplaceServicesFailure extends GetMarketplaceServicesState {
  const GetMarketplaceServicesFailure({required super.errorMessage});
}
