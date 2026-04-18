import 'dart:io';

import 'package:dio/dio.dart';

class ServiceApiService {
  final Dio _dio;
  ServiceApiService(this._dio);

  Future<Response<dynamic>> getServices() {
    return _dio.get('/services/me');
  }

  Future<Response<dynamic>> addServices(Map<String, dynamic> data) {
    return _dio.post('/services', data: data);
  }
  Future<Response<dynamic>> uploadImages(List<File> data) async{
     final formData = FormData();
     for (var file in data){
      formData.files.add(MapEntry(
      'images', 
      await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    ));
     }
    return _dio.post('/uploads/service-images', data: formData,);
  }
}
