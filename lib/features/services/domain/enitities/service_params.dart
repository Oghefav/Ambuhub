import 'dart:io';

class ServiceParams {
  final String title;
  final String description;
  final String serviceCategory;
  final String dept;
  final List<File> photoUrls;

  const ServiceParams({
    required this.dept,
    required this.description,
    required this.photoUrls,
    required this.serviceCategory,
    required this.title,
  });
}