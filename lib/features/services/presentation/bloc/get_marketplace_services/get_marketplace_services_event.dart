import 'package:equatable/equatable.dart';

abstract class GetMarketplaceServicesEvent extends Equatable {
  final String categorySlug;
  final bool forceRefresh;

  const GetMarketplaceServicesEvent({
    required this.categorySlug,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [categorySlug, forceRefresh];
}

class GetMarketplaceServices extends GetMarketplaceServicesEvent {
  const GetMarketplaceServices({
    required super.categorySlug,
    super.forceRefresh,
  });
}
