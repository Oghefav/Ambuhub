import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_wallet_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/repository/provider_dashboard_repository.dart';

class GetProviderWalletUsecase
    implements Usecase<DataState<ProviderWalletEntity>, void> {
  final ProviderDashboardRepository _repository;

  const GetProviderWalletUsecase(this._repository);

  @override
  Future<DataState<ProviderWalletEntity>> call({void params}) {
    return _repository.getWallet();
  }
}
