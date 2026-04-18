import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/core/resources/get_category_slug.dart';
import 'package:ambuhub/core/resources/get_dept_slug.dart';
import 'package:ambuhub/features/services/data/data_source/service_api_service.dart';
import 'package:ambuhub/features/services/data/model/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';
import 'package:dio/dio.dart';

class ServiceRepoImplementation implements ServiceRepo {
  final ServiceApiService _serviceApiService;

  const ServiceRepoImplementation(this._serviceApiService);

  @override
  Future<DataState<List<ServiceEntity>>> getServices() async {
    try {
      final httpResponse = await _serviceApiService.getServices();
      if (httpResponse.statusCode == 200) {
        final List<dynamic> data = httpResponse.data['services'];

        final services = data.map((e) {
          return ServiceModel.fromJson(e as Map<String, dynamic>);
        }).toList();

        return DataSuccess(data: services);
      } else {
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
    } on DioException catch (e) {
      print(e.message);
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<ServiceEntity>> addService(ServiceParams data) async {
    final serviceImages = data.photoUrls;

    try {
      final uploadImagesResponse = await _serviceApiService.uploadImages(
        serviceImages,
      );
      List<String> photoUrls = [];
      if (uploadImagesResponse.statusCode == 200 ||
          uploadImagesResponse.statusCode == 201) {
        photoUrls = (uploadImagesResponse.data['urls'] as List? ?? [])
            .map((url) => url.toString())
            .toList();
        final service = {
          'title': data.title,
          'description': data.description,
          'serviceCategorySlug': getCategorySlug(data.serviceCategory),
          'departmentSlug': getDepartmentSlug(data.dept),
          'photoUrls': photoUrls,
        };
        print(service);
        try {
          final httpResponse = await _serviceApiService.addServices(service);
          if (httpResponse.statusCode == 200 ||
              httpResponse.statusCode == 201) {
            final data = httpResponse.data['service'];
            final service = ServiceModel.fromJson(data as Map<String, dynamic>);
            print(service);
            return DataSuccess(data: service);
          } else {
            final DioException dioException = DioException(
              requestOptions: httpResponse.requestOptions,
              error: httpResponse.statusMessage,
              type: DioExceptionType.badResponse,
            );
            print(httpResponse.statusCode);
            return DataFailed(
              ErrorHandler.getErrorMessage(dioException),
              error: dioException,
            );
          }
        } on DioException catch (e) {
          return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
        }
      } else {
        final DioException dioException = DioException(
          requestOptions: uploadImagesResponse.requestOptions,
          error: uploadImagesResponse.statusMessage,
          type: DioExceptionType.badResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      print(e.error);
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
}
