import 'package:equatable/equatable.dart';

class ProviderWalletEntity extends Equatable {
  final double balanceNgn;
  final String currency;

  const ProviderWalletEntity({
    required this.balanceNgn,
    this.currency = 'NGN',
  });

  @override
  List<Object?> get props => [balanceNgn, currency];
}
