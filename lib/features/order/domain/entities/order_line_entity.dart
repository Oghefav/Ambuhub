import 'package:equatable/equatable.dart';

/// One row in [OrderEntity.lines].
class OrderLineEntity extends Equatable {
  final String serviceId;
  final String sellerUserId;
  final String lineKind;
  final String title;
  final int unitPriceNgn;
  final int quantity;
  final int lineTotalNgn;
  final String categoryName;
  final String categorySlug;
  final String departmentName;
  final List<String>? imageUrls;
  final DateTime? hireStart;
  final DateTime? hireEnd;
  final String? pricingPeriod;
  final int? hireBillableUnits;

  const OrderLineEntity({
    required this.serviceId,
    required this.sellerUserId,
    required this.lineKind,
    required this.title,
    required this.unitPriceNgn,
    required this.quantity,
    required this.lineTotalNgn,
    required this.categoryName,
    required this.categorySlug,
    required this.departmentName,
    this.imageUrls,
    this.hireStart,
    this.hireEnd,
    this.pricingPeriod,
    this.hireBillableUnits,
  });

  bool get isHire => lineKind.toLowerCase() == 'hire';

  /// First non-empty URL from [imageUrls], if any.
  String? get primaryImageUrl {
    final urls = imageUrls;
    if (urls == null || urls.isEmpty) return null;
    for (final url in urls) {
      final trimmed = url.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        serviceId,
        sellerUserId,
        lineKind,
        title,
        unitPriceNgn,
        quantity,
        lineTotalNgn,
        categoryName,
        categorySlug,
        departmentName,
        imageUrls,
        hireStart,
        hireEnd,
        pricingPeriod,
        hireBillableUnits,
      ];
}
