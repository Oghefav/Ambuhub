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
    super.createdAt,
    super.updatedAt,
  });

  static Map<String, dynamic> toJson(
    ServiceParams serviceParams,
    List<String> photoUrls,
  ) {
    final countryCode = normalizeIso3166Alpha2(serviceParams.country);
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
      'pricePeriod': serviceParams.pricePeriod,
      if (countryCode != null) 'countryCode': countryCode,
      'stateProvince': serviceParams.stateProvince,
      'stateProvinceName': serviceParams.stateProvinceName,
      'officeAddress': serviceParams.officeAddress,
      if (serviceParams.hireReturnWindow != null)
        'hireReturnWindow': {
          'daysOfWeek': serviceParams.hireReturnWindow!.daysOfWeek,
          'timeStart': serviceParams.hireReturnWindow!.timeStart,
          'timeEnd': serviceParams.hireReturnWindow!.timeEnd,
        },
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final countryRaw = (json['countryCode'] ?? json['country'])?.toString().trim();
    final countryDisplay = countryRaw == null || countryRaw.isEmpty
        ? null
        : (countryCodeToCountryName(countryRaw) ?? countryRaw);

    return ServiceModel(
      id: (json['_id'] ?? json['id'] ?? json['serviceId']).toString(),
      dept: json['departmentName'] ?? json['departmentSlug'],
      description: json['description'] ?? '',
      photoUrls: (json['photoUrls'] as List? ?? [])
          .map((url) => url.toString())
          .toList(),
      serviceCategory: json['category']?['name'] ?? json['serviceCategoryId'],
      title: json['title'],
      listingType: json['listingType'],
      stock: json['stock'],
      price: json['price'],
      available: json['isAvailable'] ?? json['available'],
      pricePeriod: json['pricePeriod'] ?? json['pricingPeriod'],
      country: countryDisplay,
      stateProvince: json['stateProvince'],
      stateProvinceName: json['stateProvinceName'],
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
      createdAt: tryParseDateTime(json['createdAt']),
      updatedAt: tryParseDateTime(json['updatedAt']),
    );
  }
}
