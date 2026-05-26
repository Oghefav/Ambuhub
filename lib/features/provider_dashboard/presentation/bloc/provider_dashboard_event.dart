import 'package:equatable/equatable.dart';

abstract class ProviderDashboardEvent extends Equatable {
  const ProviderDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadProviderDashboard extends ProviderDashboardEvent {
  const LoadProviderDashboard({this.forceRefresh = false});

  final bool forceRefresh;

  @override
  List<Object?> get props => [forceRefresh];
}

class LoadProviderWallet extends ProviderDashboardEvent {
  const LoadProviderWallet({this.forceRefresh = false});

  final bool forceRefresh;

  @override
  List<Object?> get props => [forceRefresh];
}

class LoadProviderYearlySales extends ProviderDashboardEvent {
  const LoadProviderYearlySales({
    required this.year,
    this.forceRefresh = false,
  });

  final int year;
  final bool forceRefresh;

  @override
  List<Object?> get props => [year, forceRefresh];
}

class SelectProviderSalesYear extends ProviderDashboardEvent {
  const SelectProviderSalesYear(this.year);

  final int year;

  @override
  List<Object?> get props => [year];
}

class ProviderDashboardReset extends ProviderDashboardEvent {
  const ProviderDashboardReset();
}
