import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';

class ProviderMonthlySalesPointModel extends ProviderMonthlySalesPointEntity {
  const ProviderMonthlySalesPointModel({
    required super.yearMonth,
    required super.label,
    required super.totalNgn,
  });

  factory ProviderMonthlySalesPointModel.fromJson(Map<String, dynamic> json) {
    return ProviderMonthlySalesPointModel(
      yearMonth: json['yearMonth']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      totalNgn: _parseAmount(json['totalNgn']),
    );
  }

  static double _parseAmount(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }
}

class ProviderYearlySalesModel extends ProviderYearlySalesEntity {
  const ProviderYearlySalesModel({
    required super.year,
    required super.months,
  });

  static Map<String, dynamic> _unwrapPayload(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    final sales = json['sales'];
    if (sales is Map<String, dynamic>) {
      return sales;
    }
    return json;
  }

  factory ProviderYearlySalesModel.fromJson(Map<String, dynamic> json) {
    final payload = _unwrapPayload(json);
    final rawMonths = payload['months'];
    final months = rawMonths is List
        ? rawMonths
            .whereType<Map>()
            .map(
              (item) => ProviderMonthlySalesPointModel.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList()
        : <ProviderMonthlySalesPointModel>[];

    final year = payload['year'] is int
        ? payload['year'] as int
        : int.tryParse(payload['year']?.toString() ?? '') ??
            DateTime.now().year;

    return ProviderYearlySalesModel(
      year: year,
      months: months.isNotEmpty
          ? months
          : ProviderYearlySalesModel.emptyMonths(year),
    );
  }

  static List<ProviderMonthlySalesPointModel> emptyMonths(int year) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return List.generate(
      12,
      (index) => ProviderMonthlySalesPointModel(
        yearMonth:
            '$year-${(index + 1).toString().padLeft(2, '0')}',
        label: labels[index],
        totalNgn: 0,
      ),
    );
  }
}
