import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_wallet_entity.dart';

abstract class ProviderDashboardRepository {
  Future<DataState<ProviderWalletEntity>> getWallet();

  Future<DataState<ProviderYearlySalesEntity>> getSalesByMonth({
    required int year,
  });
}
