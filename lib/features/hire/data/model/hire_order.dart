import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_entity.dart';

class HireOrderModel extends HireEntity {
  const HireOrderModel({
    required super.id,
    required super.serviceId,
    required super.quantity,
    required super.hireStart,
    required super.hireEnd,
  });

  factory HireOrderModel.fromJson(Map<String, dynamic> json) {
    final order = json['order'] is Map<String, dynamic>
        ? json['order'] as Map<String, dynamic>
        : json;

    return HireOrderModel(
      id: order['_id']?.toString() ?? order['id']?.toString() ?? '',
      serviceId: order['serviceId']?.toString() ?? '',
      quantity: (order['quantity'] as num?)?.toInt() ?? 0,
      hireStart: tryParseDateTime(order['hireStart']) ?? DateTime.now(),
      hireEnd: tryParseDateTime(order['hireEnd']) ?? DateTime.now(),
    );
  }
}
