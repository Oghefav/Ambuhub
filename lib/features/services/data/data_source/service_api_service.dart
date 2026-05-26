import 'dart:io';

import 'package:dio/dio.dart';

class ServiceApiService {
  final Dio _dio;
  ServiceApiService(this._dio);

  Future<Response<dynamic>> getProviderServices() {
    return _dio.get('/services/me');
  }

  Future<Response<dynamic>> getMarketplaceServices(String categorySlug) {
    final params = {'categorySlug': categorySlug};
    return _dio.get('/services/marketplace', queryParameters: params);
  }

  Future<Response<dynamic>> getMarketplaceServiceById(String serviceId) {
    return _dio.get('/services/marketplace/$serviceId');
  }

  Future<Response<dynamic>> addServices(Map<String, dynamic> data) {
    return _dio.post('/services', data: data);
  }

  Future<Response<dynamic>> uploadImages(List<File> data) async {
    final formData = FormData();
    for (var file in data) {
      formData.files.add(
        MapEntry(
          'images',
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }
    return _dio.post('/uploads/service-images', data: formData);
  }

  Future<Response<dynamic>> getServiceCategories() {
    return _dio.get('/service-categories');
  }
  
  Future<Response<dynamic>> updateService(Map<String, dynamic> data) {
    return _dio.put('/services/${data['id']}', data: data);
  }

  Future<Response<dynamic>> updateServiceAvailability({
    required String serviceId,
    required bool isAvailable,
  }) {
    return _dio.patch(
      '/services/$serviceId/availability',
      data: {'isAvailable': isAvailable},
    );
  }

  Future<Response<dynamic>> deleteService(String serviceId) {
    return _dio.delete('/services/$serviceId');
  }
}
