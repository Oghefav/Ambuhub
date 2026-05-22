import 'package:equatable/equatable.dart';

abstract class GetMarketplaceServicesEvent extends Equatable {
  const GetMarketplaceServicesEvent();

  @override
  List<Object?> get props => [];
}

class GetMarketplaceServices extends GetMarketplaceServicesEvent {
  final String categorySlug;
  final bool forceRefresh;

  const GetMarketplaceServices({
    required this.categorySlug,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [categorySlug, forceRefresh];
}

class GetMarketplaceServiceById extends GetMarketplaceServicesEvent {
  final String serviceId;

  const GetMarketplaceServiceById({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}

class ClearMarketplaceServiceDetail extends GetMarketplaceServicesEvent {
  const ClearMarketplaceServiceDetail();
}
