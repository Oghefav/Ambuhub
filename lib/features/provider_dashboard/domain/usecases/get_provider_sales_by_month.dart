import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/repository/provider_dashboard_repository.dart';

class GetProviderSalesByMonthParams {
  final int year;

  const GetProviderSalesByMonthParams({required this.year});
}

class GetProviderSalesByMonthUsecase
    implements
        Usecase<DataState<ProviderYearlySalesEntity>,
            GetProviderSalesByMonthParams> {
  final ProviderDashboardRepository _repository;

  const GetProviderSalesByMonthUsecase(this._repository);

  @override
  Future<DataState<ProviderYearlySalesEntity>> call({
    GetProviderSalesByMonthParams? params,
  }) {
    return _repository.getSalesByMonth(year: params!.year);
  }
}
