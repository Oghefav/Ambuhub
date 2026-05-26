import 'package:equatable/equatable.dart';

class ProviderMonthlySalesPointEntity extends Equatable {
  final String yearMonth;
  final String label;
  final double totalNgn;

  const ProviderMonthlySalesPointEntity({
    required this.yearMonth,
    required this.label,
    required this.totalNgn,
  });

  @override
  List<Object?> get props => [yearMonth, label, totalNgn];
}

class ProviderYearlySalesEntity extends Equatable {
  final int year;
  final List<ProviderMonthlySalesPointEntity> months;

  const ProviderYearlySalesEntity({
    required this.year,
    required this.months,
  });

  double get yearTotalNgn =>
      months.fold<double>(0, (sum, month) => sum + month.totalNgn);

  bool get hasQualifyingOrders => yearTotalNgn > 0;

  @override
  List<Object?> get props => [year, months];
}
