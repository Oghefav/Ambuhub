import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:equatable/equatable.dart';

/// Shared shape for [ServiceEntity.hireReturnWindow] and [ServiceEntity.bookingWindow].
class WeeklyTimeWindowEntity extends Equatable {
  final List<int> daysOfWeek;
  final String timeStart;
  final String timeEnd;

  const WeeklyTimeWindowEntity({
    required this.daysOfWeek,
    required this.timeStart,
    required this.timeEnd,
  });

  factory WeeklyTimeWindowEntity.fromJson(Map<String, dynamic> json) {
    return WeeklyTimeWindowEntity(
      daysOfWeek: (json['daysOfWeek'] as List? ?? [])
          .map((e) => (e as num).toInt())
          .toList(),
      timeStart: json['timeStart'] as String? ?? '',
      timeEnd: json['timeEnd'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [daysOfWeek, timeStart, timeEnd];

  /// e.g. `Mon - Fri`, `Mon - Tue, Thu - Fri`, or `Tue, Fri`
  String get formattedDaysOfWeek => formatDaysOfWeek(daysOfWeek);
}

class ServiceEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String serviceCategory;
  final String dept;
  final List<String> photoUrls;
  final String? listingType;
  final int? stock;
  final int? price;
  final bool? available;
  final String? pricePeriod;
  final String? country;
  final String? stateProvince;
  final String? stateProvinceName;
  final String? officeAddress;
  final WeeklyTimeWindowEntity? hireReturnWindow;
  final WeeklyTimeWindowEntity? bookingWindow;
  final int? bookingGapMinutes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ServiceEntity({
    required this.id,
    required this.dept,
    required this.description,
    required this.photoUrls,
    required this.serviceCategory,
    required this.title,
    this.pricePeriod,
    this.listingType,
    this.stock,
    this.price,
    this.available,
    this.country,
    this.stateProvince,
    this.stateProvinceName,
    this.officeAddress,
    this.hireReturnWindow,
    this.bookingWindow,
    this.bookingGapMinutes,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        serviceCategory,
        dept,
        photoUrls,
        listingType,
        stock,
        price,
        available,
        pricePeriod,
        country,
        stateProvince,
        stateProvinceName,
        officeAddress,
        hireReturnWindow,
        bookingWindow,
        bookingGapMinutes,
        createdAt,
        updatedAt,
      ];
}
