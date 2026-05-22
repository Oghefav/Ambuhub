import 'package:dio/dio.dart';

class ReviewsApiService {
  final Dio _dio;

  ReviewsApiService(this._dio);

  Future<Response<dynamic>> getAwaitingReviews() {
    return _dio.get('/reviews/me/eligible');
  }

  Future<Response<dynamic>> getWrittenReviews() {
    return _dio.get('/reviews/me');
  }

  Future<Response<dynamic>> writeReview(Map<String, dynamic> data) {
    return _dio.post('/reviews/', data: data);
  }

  Future<Response<dynamic>> getReviewById(String reviewId) {
    return _dio.get('/reviews/by-service/$reviewId');
  }

  Future<Response<dynamic>> getServiceReviews(String serviceId) {
    return _dio.get('/reviews/by-service/$serviceId');
  }
}
