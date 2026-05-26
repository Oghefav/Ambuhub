import 'dart:io';

import 'package:ambuhub/features/services/domain/enitities/service.dart';

class ServiceParams {
  final String? id;
  final String title;
  final String description;
  final String serviceCategory;
  final String dept;
  final List<File> photoUrls;
  final String? listingType;
  final List<String>? uploadedPhotoUrls;
  final int? stock;
  final int? price;
  final String? country;
  final String? stateProvince;
  final String? stateProvinceName;
  final String? officeAddress;
  final String? pricePeriod;
  final WeeklyTimeWindowEntity? hireReturnWindow;

  const ServiceParams({
    this.id,
    required this.dept,
    required this.description,
    required this.photoUrls,
    required this.serviceCategory,
    required this.title,
    this.listingType,
    this.stock,
    this.price,
    this.uploadedPhotoUrls,
    this.country,
    this.stateProvince,
    this.stateProvinceName,
    this.officeAddress,
    this.pricePeriod,
    this.hireReturnWindow,
  });
}
