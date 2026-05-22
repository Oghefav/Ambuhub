import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class GetMarketplaceServicesState extends Equatable {
  final List<ServiceEntity>? services;
  final String? errorMessage;
  final String? categorySlug;
  final ServiceEntity? loadedService;
  final String? serviceByIdError;
  final bool isLoadingServiceById;
  final String? pendingServiceById;

  const GetMarketplaceServicesState({
    this.services,
    this.errorMessage,
    this.categorySlug,
    this.loadedService,
    this.serviceByIdError,
    this.isLoadingServiceById = false,
    this.pendingServiceById,
  });

  @override
  List<Object?> get props => [
        services,
        errorMessage,
        categorySlug,
        loadedService,
        serviceByIdError,
        isLoadingServiceById,
        pendingServiceById,
      ];
}

class GetMarketplaceServicesInitial extends GetMarketplaceServicesState {
  const GetMarketplaceServicesInitial({
    super.loadedService,
    super.serviceByIdError,
    super.isLoadingServiceById,
    super.pendingServiceById,
  });
}

class GetMarketplaceServicesLoading extends GetMarketplaceServicesState {
  const GetMarketplaceServicesLoading({
    super.services,
    super.categorySlug,
    super.loadedService,
    super.serviceByIdError,
    super.isLoadingServiceById,
    super.pendingServiceById,
  });
}

class GetMarketplaceServicesSuccess extends GetMarketplaceServicesState {
  const GetMarketplaceServicesSuccess({
    required super.services,
    required super.categorySlug,
    super.loadedService,
    super.serviceByIdError,
    super.isLoadingServiceById,
    super.pendingServiceById,
  });
}

class GetMarketplaceServicesFailure extends GetMarketplaceServicesState {
  const GetMarketplaceServicesFailure({
    required super.errorMessage,
    super.services,
    super.categorySlug,
    super.loadedService,
    super.serviceByIdError,
    super.isLoadingServiceById,
    super.pendingServiceById,
  });
}
