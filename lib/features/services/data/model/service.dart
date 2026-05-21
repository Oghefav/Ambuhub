import 'package:ambuhub/core/utililty/locale_display_utils.dart';
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
    super.available,
    super.pricePeriod,
    super.country,
    super.stateProvince,
    super.stateProvinceName,
    super.officeAddress,
    super.hireReturnWindow,
    super.bookingWindow,
    super.bookingGapMinutes,
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
      // 'pricePeriod': serviceParams.pricePeriod,
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final countryRaw = json['country']?.toString().trim();
    final countryDisplay = countryRaw == null || countryRaw.isEmpty
        ? null
        : (countryCodeToCountryName(countryRaw) ?? countryRaw);

    return ServiceModel(
      id: json['_id'] ?? json['id'] ?? json['serviceId'],
      dept: json['departmentName'] ?? json['departmentSlug'],
      description: json['description'] ?? '',
      photoUrls: (json['photoUrls'] as List? ?? [])
          .map((url) => url.toString())
          .toList(),
      serviceCategory: json['category']?['name'] ?? json['serviceCategoryId'],
      title: json['title'],
      listingType: json['listingType'] ,
      stock: json['stock'],
      price: json['price'],
      available: json['available'],
      pricePeriod: json['pricePeriod'],
      country: countryDisplay,
      stateProvince: json['stateProvince'],
      stateProvinceName: json['stateProvinceName'] ,
      officeAddress: json['officeAddress'],
      hireReturnWindow: json['hireReturnWindow'] != null
          ? WeeklyTimeWindowEntity.fromJson(
              Map<String, dynamic>.from(json['hireReturnWindow'] as Map),
            )
          : null,
      bookingWindow: json['bookingWindow'] != null
          ? WeeklyTimeWindowEntity.fromJson(
              Map<String, dynamic>.from(json['bookingWindow'] as Map),
            )
          : null,
      bookingGapMinutes: (json['bookingGapMinutes'] as num?)?.toInt(),
    );
  }
}
