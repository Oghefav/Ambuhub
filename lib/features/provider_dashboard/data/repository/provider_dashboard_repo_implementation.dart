import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/provider_dashboard/data/data_source/remote/provider_dashboard_api_service.dart';
import 'package:ambuhub/features/provider_dashboard/data/model/provider_wallet_model.dart';
import 'package:ambuhub/features/provider_dashboard/data/model/provider_yearly_sales_model.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_monthly_sales_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/entities/provider_wallet_entity.dart';
import 'package:ambuhub/features/provider_dashboard/domain/repository/provider_dashboard_repository.dart';
import 'package:dio/dio.dart';

class ProviderDashboardRepoImplementation implements ProviderDashboardRepository {
  final ProviderDashboardApiService _apiService;

  const ProviderDashboardRepoImplementation(this._apiService);

  @override
  Future<DataState<ProviderWalletEntity>> getWallet() async {
    try {
      final response = await _apiService.getWallet();
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return DataSuccess(data: ProviderWalletModel.fromJson(data));
        }
        return const DataSuccess(
          data: ProviderWalletModel(balanceNgn: 0),
        );
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<ProviderYearlySalesEntity>> getSalesByMonth({
    required int year,
  }) async {
    try {
      final response = await _apiService.getSalesByMonth(year: year);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return DataSuccess(
            data: ProviderYearlySalesModel.fromJson(
              Map<String, dynamic>.from(data),
            ),
          );
        }
        return DataSuccess(
          data: ProviderYearlySalesModel(
            year: year,
            months: ProviderYearlySalesModel.emptyMonths(year),
          ),
        );
      }
      final error = DioException(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        type: DioExceptionType.badResponse,
        response: response,
      );
      return DataFailed(ErrorHandler.getErrorMessage(error), error: error);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
