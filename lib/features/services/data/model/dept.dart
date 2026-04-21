import 'package:ambuhub/features/services/domain/enitities/dept.dart';

class ServiceDeptModel extends ServiceDeptEntity {
  const ServiceDeptModel({required super.name, required super.slug});

  factory ServiceDeptModel.fromJson(Map<String, dynamic> json) {
    return ServiceDeptModel(name: json['name'], slug: json['slug']);
  }
}
