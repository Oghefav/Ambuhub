import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/domain/enitities/service_params.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.dept,
    required super.description,
    required super.photoUrls,
    required super.serviceCategory,
    required super.title,
    required super.id,
    super.listingType,
    super.stock,
    super.price,
  });

  static Map<String, dynamic> toJson(
    ServiceParams serviceParams,
    List<String> photoUrls,
  ) {
    return {
      'id': serviceParams.id,
      'title': serviceParams.title,
      'description': serviceParams.description,
      'serviceCategorySlug': serviceParams.serviceCategory,
      'departmentSlug': serviceParams.dept,
      'photoUrls': photoUrls,
      'listingType': serviceParams.listingType?.toLowerCase(),
      'stock': serviceParams.stock,
      'price': serviceParams.price,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? json['id'],
      dept: json['departmentName'] ?? json['departmentSlug'],
      description: json['description'],
      photoUrls: (json['photoUrls'] as List? ?? [])
          .map((url) => url.toString())
          .toList(),
      serviceCategory: json['category']?['name'] ?? json['serviceCategoryId'],
      title: json['title'],
      listingType: json['listingType'] != null
          ? (json['listingType'] as String)
                .toTitleCase() // ← 'sale' → 'Sale'
          : null,
      stock: json['stock'],
      price: json['price'],
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
