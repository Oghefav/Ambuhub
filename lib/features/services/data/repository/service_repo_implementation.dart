import 'dart:io';

import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/resources/error_handler.dart';
import 'package:ambuhub/features/services/data/data_source/service_api_service.dart';
import 'package:ambuhub/features/services/data/model/category.dart';
import 'package:ambuhub/features/services/data/model/service.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:ambuhub/features/services/domain/repository/service_repo.dart';
import 'package:dio/dio.dart';

class ServiceRepoImplementation implements ServiceRepo {
  final ServiceApiService _serviceApiService;

  const ServiceRepoImplementation(this._serviceApiService);

  
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
        final service = ServiceModel.toJson(data, photoUrls);
        print(service);
        try {
          final httpResponse = await _serviceApiService.addServices(service);
          if (httpResponse.statusCode == 200 ||
              httpResponse.statusCode == 201) {
            final data = httpResponse.data['service'];
            print(data);
            final service = ServiceModel.fromJson(data as Map<String, dynamic>);
            return DataSuccess(data: service);
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
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<List<ServiceCategoryEntity>>> getServiceCategories() async {
    try {
      final httpResponse = await _serviceApiService.getServiceCategories();
      if (httpResponse.statusCode == 200) {
        final List<dynamic> data = httpResponse.data['serviceCategories'];
        final List<ServiceCategoryEntity> serviceCategories = data
            .map((e) => ServiceCategoryModel.fromJson(e))
            .toList();
        return DataSuccess(data: serviceCategories);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          type: DioExceptionType.badResponse,
          error: httpResponse.statusMessage,
          response: httpResponse,
        );
        return DataFailed(
          ErrorHandler.getErrorMessage(dioException),
          error: dioException,
        );
      }
    } on DioException catch (e) {
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<List<ServiceEntity>>> getMarketplaceServices(
    String categorySlug,
  ) async {
    try{
      final httpResponse = await _serviceApiService.getMarketplaceServices(categorySlug);
      if (httpResponse.statusCode == 200) {
        final List<dynamic> data = httpResponse.data['services'];
        final List<ServiceEntity> services = data.map((e) => ServiceModel.fromJson(e)).toList();
        return DataSuccess(data: services);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          type: DioExceptionType.badResponse,
          error: httpResponse.statusMessage,
          response: httpResponse,
        );
        return DataFailed(ErrorHandler.getErrorMessage(dioException), error: dioException);
      }

    } on DioException catch (e){
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }
  @override
  Future<DataState<List<ServiceEntity>>> getProviderServices() async {
    try{
      final httpResponse = await _serviceApiService.getProviderServices();
      if (httpResponse.statusCode == 200) {
        final List<dynamic> data = httpResponse.data['services'];
        final List<ServiceEntity> services = data.map((e) => ServiceModel.fromJson(e)).toList();
        return DataSuccess(data: services);
      } else {
        final DioException dioException = DioException(
          requestOptions: httpResponse.requestOptions,
          type: DioExceptionType.badResponse,
          error: httpResponse.statusMessage,
          response: httpResponse,
        );
        return DataFailed(ErrorHandler.getErrorMessage(dioException), error: dioException);
      }

    } on DioException catch (e){
      return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
    }
  }

  @override
  Future<DataState<ServiceEntity>> updateService(ServiceParams service) async {
    final List<String> existingUrls = service.uploadedPhotoUrls ?? [];
    final List<File> filesToUpload = service.photoUrls
        .where((file) => !existingUrls.contains(file.path))
        .toList();

    try {
      List<String> finalPhotoUrls = List.from(existingUrls);
      if (filesToUpload.isNotEmpty) {
        try {
          final uploadImagesResponse = await _serviceApiService.uploadImages(
            filesToUpload,
          );

          if (uploadImagesResponse.statusCode == 200 ||
              uploadImagesResponse.statusCode == 201) {
            final newUrls = (uploadImagesResponse.data['urls'] as List? ?? [])
                .map((url) => url.toString())
                .toList();

            finalPhotoUrls.addAll(newUrls);
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
          return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
        }
      }
      final serviceBody = ServiceModel.toJson(service, finalPhotoUrls);

      try {
        final httpResponse = await _serviceApiService.updateService(
          serviceBody,
        );
        print('im here');
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
          final data = httpResponse.data['service'];
          final updatedService = ServiceModel.fromJson(
            data as Map<String, dynamic>,
          );
          print(updatedService);
          return DataSuccess(data: updatedService);
        } else {
          print('im here 2');
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
        return DataFailed(ErrorHandler.getErrorMessage(e), error: e);
      }
    } catch (e) {
      return DataFailed("An unexpected error occurred: ${e.toString()}");
    }
  }
}
