import 'package:equatable/equatable.dart';

abstract class MarketplaceServiceDetailEvent extends Equatable {
  const MarketplaceServiceDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadMarketplaceServiceDetail extends MarketplaceServiceDetailEvent {
  final String serviceId;

  const LoadMarketplaceServiceDetail({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}
