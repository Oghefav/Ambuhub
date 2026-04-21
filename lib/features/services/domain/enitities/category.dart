import 'package:ambuhub/features/services/domain/enitities/dept.dart';
import 'package:equatable/equatable.dart';

class ServiceCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final List<ServiceDeptEntity> departments;
  final String thumbnailUrl;
  final String bannerUrl;
  final String note;

  const ServiceCategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.departments,
    required this.thumbnailUrl,
    required this.bannerUrl,
    required this.note,
  });

  @override
  List<Object> get props => [id, name, slug];
}
