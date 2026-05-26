import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_wallet_entity.dart';

class ProviderWalletModel extends ProviderWalletEntity {
  const ProviderWalletModel({
    required super.balanceNgn,
    super.currency,
  });

  factory ProviderWalletModel.fromJson(Map<String, dynamic> json) {
    final wallet = json['wallet'];
    final source = wallet is Map<String, dynamic> ? wallet : json;

    return ProviderWalletModel(
      balanceNgn: _parseAmount(source['balanceNgn']),
      currency: source['currency']?.toString() ?? 'NGN',
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
