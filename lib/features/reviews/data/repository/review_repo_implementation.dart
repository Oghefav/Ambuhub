import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/reviews/data/data_source/remote/reviews_api_service.dart';
import 'package:ambuhub/features/reviews/data/model/awaiting_review_model.dart';
import 'package:ambuhub/features/reviews/data/model/service_reviews_model.dart';
import 'package:ambuhub/features/reviews/data/model/written_review_model.dart';
import 'package:ambuhub/features/reviews/domain/entities/service_reviews.dart';
import 'package:ambuhub/features/reviews/domain/entities/awaiting_review.dart';
import 'package:ambuhub/features/reviews/domain/entities/write_review_params.dart';
import 'package:ambuhub/features/reviews/domain/entities/written_review.dart';
import 'package:ambuhub/features/reviews/domain/repository/review_repo.dart';
import 'package:dio/dio.dart';

class ReviewRepoImplementation implements ReviewRepo {
  final ReviewsApiService _apiService;

  const ReviewRepoImplementation(this._apiService);

  List<AwaitingReviewEntity> _parseAwaitingList(dynamic raw) {
    final list = _extractList(
      raw,
      keys: const [
        'eligible',
        'awaitingReviews',
        'eligibleReviews',
        'awaiting',
        'reviews',
        'data',
      ],
    );
    return list
        .whereType<Map<String, dynamic>>()
        .map(AwaitingReviewModel.fromJson)
        .toList();
  }

  List<WrittenReviewEntity> _parseWrittenList(dynamic raw) {
    final list = _extractList(
      raw,
      keys: const ['writtenReviews', 'written', 'reviews', 'data'],
    );
    return list
        .whereType<Map<String, dynamic>>()
        .map(WrittenReviewModel.fromJson)
        .toList();
  }

  WrittenReviewEntity _parseWrittenOne(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final nested = raw['review'];
      if (nested is Map<String, dynamic>) {
        return WrittenReviewModel.fromJson(nested);
      }
      return WrittenReviewModel.fromJson(raw);
    }
    throw const FormatException('Invalid review response');
  }

  List<dynamic> _extractList(
    dynamic raw, {
    required List<String> keys,
  }) {
    if (raw is List) return raw;
    if (raw is! Map<String, dynamic>) return [];
    for (final key in keys) {
      final value = raw[key];
      if (value is List) return value;
    }
    return [];
  }

  DataFailed<T> _badResponse<T>(Response<dynamic> response) {
    final dioException = DioException(
      requestOptions: response.requestOptions,
      error: response.statusMessage,
      type: DioExceptionType.badResponse,
      response: response,
    );
    return DataFailed(
      ErrorHandler.getErrorMessage(dioException),
      error: dioException,
    );
  }

  @override
  Future<DataState<List<AwaitingReviewEntity>>> getAwaitingReviews() async {
    try {
      final httpResponse = await _apiService.getAwaitingReviews();
      if (httpResponse.statusCode == 200) {
        return DataSuccess(data: _parseAwaitingList(httpResponse.data));
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<List<WrittenReviewEntity>>> getWrittenReviews() async {
    try {
      final httpResponse = await _apiService.getWrittenReviews();
      if (httpResponse.statusCode == 200) {
        return DataSuccess(data: _parseWrittenList(httpResponse.data));
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<WrittenReviewEntity>> writeReview(
    WriteReviewParams params,
  ) async {
    try {
      final httpResponse =
          await _apiService.writeReview(params.toJson());
      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        return DataSuccess(data: _parseWrittenOne(httpResponse.data));
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<WrittenReviewEntity>> getReviewById(String reviewId) async {
    try {
      final httpResponse = await _apiService.getReviewById(reviewId);
      if (httpResponse.statusCode == 200) {
        return DataSuccess(data: _parseWrittenOne(httpResponse.data));
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<ServiceReviewsEntity>> getServiceReviews(
    String serviceId,
  ) async {
    try {
      final httpResponse = await _apiService.getServiceReviews(serviceId);
      if (httpResponse.statusCode == 200) {
        final raw = httpResponse.data;
        if (raw is Map<String, dynamic>) {
          return DataSuccess(data: ServiceReviewsModel.fromJson(raw));
        }
        if (raw is Map) {
          return DataSuccess(
            data: ServiceReviewsModel.fromJson(
              Map<String, dynamic>.from(raw),
            ),
          );
        }
        return DataFailed('Invalid service reviews response');
      }
      return _badResponse(httpResponse);
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
