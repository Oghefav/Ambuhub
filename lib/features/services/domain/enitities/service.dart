import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String serviceCategory;
  final String dept;
  final List<String> photoUrls;

  const ServiceEntity({
    required this.id,
    required this.dept,
    required this.description,
    required this.photoUrls,
    required this.serviceCategory,
    required this.title,
  });

  @override
  List<Object> get props => [id, title, description, photoUrls];
}
