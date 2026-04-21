import 'package:ambuhub/features/services/data/model/dept.dart';
import 'package:ambuhub/features/services/domain/enitities/category.dart';

class ServiceCategoryModel extends ServiceCategoryEntity {
  const ServiceCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.bannerUrl,
    required super.thumbnailUrl,
    required super.departments,
    required super.note,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      departments: (json['departments'] as List? ?? [])
          .map((e) => ServiceDeptModel.fromJson(e))
          .toList(),
      bannerUrl: json['bannerUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      note: json['note'],
    );
  }
}
