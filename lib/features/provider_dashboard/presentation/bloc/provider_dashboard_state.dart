import 'package:ambuhub/features/provider_dashboard/data/model/provider_yearly_sales_model.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:equatable/equatable.dart';

class ProviderDashboardState extends Equatable {
  final double walletBalanceNgn;
  final bool isWalletLoading;
  final bool hasWalletLoaded;
  final int selectedYear;
  final ProviderYearlySalesEntity yearlySales;
  final bool isSalesLoading;

  const ProviderDashboardState({
    this.walletBalanceNgn = 0,
    this.isWalletLoading = false,
    this.hasWalletLoaded = false,
    required this.selectedYear,
    required this.yearlySales,
    this.isSalesLoading = false,
  });

  factory ProviderDashboardState.initial() {
    final year = DateTime.now().year;
    return ProviderDashboardState(
      selectedYear: year,
      yearlySales: ProviderYearlySalesModel(
        year: year,
        months: ProviderYearlySalesModel.emptyMonths(year),
      ),
    );
  }

  ProviderDashboardState copyWith({
    double? walletBalanceNgn,
    bool? isWalletLoading,
    bool? hasWalletLoaded,
    int? selectedYear,
    ProviderYearlySalesEntity? yearlySales,
    bool? isSalesLoading,
  }) {
    return ProviderDashboardState(
      walletBalanceNgn: walletBalanceNgn ?? this.walletBalanceNgn,
      isWalletLoading: isWalletLoading ?? this.isWalletLoading,
      hasWalletLoaded: hasWalletLoaded ?? this.hasWalletLoaded,
      selectedYear: selectedYear ?? this.selectedYear,
      yearlySales: yearlySales ?? this.yearlySales,
      isSalesLoading: isSalesLoading ?? this.isSalesLoading,
    );
  }

  @override
  List<Object?> get props => [
        walletBalanceNgn,
        isWalletLoading,
        hasWalletLoaded,
        selectedYear,
        yearlySales,
        isSalesLoading,
      ];
}
