import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/hire/data/model/hire_order.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_entity.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/hire/domain/repository/hire_repo.dart';
import 'package:ambuhub/features/order/data/data_source/remote/order_api_service.dart';
import 'package:dio/dio.dart';

class HireRepoImplementation implements HireRepo {
  final OrderApiService _orderApiService;

  const HireRepoImplementation(this._orderApiService);

  @override
  Future<DataState<HireEntity>> placeHire(HireParams params) async {
    try {
      final httpResponse =
          await _orderApiService.createHireOrder(params.toJson());

      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        final data = httpResponse.data;
        if (data is Map<String, dynamic>) {
          final order = HireOrderModel.fromJson(data);
          return DataSuccess(data: order);
        }
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          error: httpResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }

      final DioException dioException = DioException(
        requestOptions: httpResponse.requestOptions,
        error: httpResponse.statusMessage,
        type: DioExceptionType.badResponse,
      );
      return DataFailed(
        ErrorHandler.getErrorMessage(dioException),
        error: dioException,
      );
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
