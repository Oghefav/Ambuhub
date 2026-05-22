import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';

class OrderLineModel extends OrderLineEntity {
  const OrderLineModel({
    required super.serviceId,
    required super.sellerUserId,
    required super.lineKind,
    required super.title,
    required super.unitPriceNgn,
    required super.quantity,
    required super.lineTotalNgn,
    required super.categoryName,
    required super.categorySlug,
    required super.departmentName,
    super.imageUrls,
    super.hireStart,
    super.hireEnd,
    super.pricingPeriod,
    super.hireBillableUnits,
  });

  factory OrderLineModel.fromJson(Map<String, dynamic> json) {
    return OrderLineModel(
      serviceId: json['serviceId']?.toString() ?? '',
      sellerUserId: json['sellerUserId']?.toString() ?? '',
      lineKind: json['lineKind'] as String? ?? '',
      title: json['title'] as String? ?? '',
      unitPriceNgn: (json['unitPriceNgn'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      lineTotalNgn: (json['lineTotalNgn'] as num?)?.toInt() ?? 0,
      categoryName: json['categoryName'] as String? ?? '',
      categorySlug: json['categorySlug'] as String? ?? '',
      departmentName: json['departmentName'] as String? ?? '',
      imageUrls: _imageUrlsFromJson(json['imageUrls']),
      hireStart: tryParseDateTime(json['hireStart']),
      hireEnd: tryParseDateTime(json['hireEnd']),
      pricingPeriod: json['pricingPeriod'] as String?,
      hireBillableUnits: (json['hireBillableUnits'] as num?)?.toInt(),
    );
  }

  static List<String>? _imageUrlsFromJson(dynamic raw) {
    if (raw == null) return null;
    if (raw is! List) return null;
    final urls = raw
        .map((e) => e.toString().trim())
        .where((url) => url.isNotEmpty)
        .toList();
    return urls.isEmpty ? null : urls;
  }
}
