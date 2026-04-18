import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final map = e.response?.data as Map<String, dynamic>;
      return map['message'] ?? map['error'] ?? 'An un expected error occurred';
    }

    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection detected.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again';
      case DioExceptionType.receiveTimeout:
        return 'The server is taking too long to respond';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        if (e.message != null && e.message!.contains('SocketException')) {
          return 'No Internet Connection';
        }
        return 'An unexpected network error occurred.';
      case DioExceptionType.badResponse:
        return _handleHttpStatusCode(e.response?.statusCode);
      default:
        return 'Something went wrong, please try again later.';
    }
  }

  static String _handleHttpStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input';
      case 401:
        return 'Session timeout. Please log in again';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Invalid status code';
    }
  }
}
