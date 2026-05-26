import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/booking/data/data_source/remote/booking_api_service.dart';
import 'package:ambuhub/features/booking/data/model/hire_booking_model.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:ambuhub/features/booking/domain/repository/booking_repo.dart';
import 'package:dio/dio.dart';

class BookingRepoImplementation implements BookingRepo {
  final BookingApiService _apiService;

  const BookingRepoImplementation(this._apiService);

  List<HireBookingEntity> _parseBookings(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final list = raw['bookings'];
      if (list is List) {
        return list
            .whereType<Map>()
            .map((e) => HireBookingModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => HireBookingModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  @override
  Future<DataState<List<HireBookingEntity>>> getProviderHireBookings() async {
    try {
      final response = await _apiService.getProviderHireBookings();
      if (response.statusCode == 200) {
        return DataSuccess(data: _parseBookings(response.data));
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
