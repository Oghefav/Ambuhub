import 'package:ambuhub/features/services/domain/enitities/service.dart';


class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.dept,
    required super.description,
    required super.photoUrls,
    required super.serviceCategory,
    required super.title,
    required super.id
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'serviceCategorySlug': serviceCategory,
      'departmentSlug': dept,
      'photoUrls': photoUrls,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? json['id'],
      dept: json['departmentSlug'],
      description: json['description'],
      photoUrls: (json['photoUrls'] as List? ??[]).map((url)=>url.toString()).toList(),
      serviceCategory: json['category']?['name']?? json['serviceCategoryId'],
      title: json['title'],
    );
  }
  // factory ServiceModel.fromEnitity(ServiceParams service) {
  //   return ServiceModel(
  //     dept: service.dept,
  //     description: service.dept,
  //     photoUrls: service.photoUrls,
  //     serviceCategory: service.serviceCategory,
  //     title: service.title,
  //   );
  // }
}


