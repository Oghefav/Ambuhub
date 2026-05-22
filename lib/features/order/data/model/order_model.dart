import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/order/data/model/order_line_model.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.receiptNumber,
    required super.currency,
    required super.subtotalNgn,
    required super.lines,
    required super.paymentProvider,
    required super.paystackReference,
    required super.paystackSimulated,
    super.paidAt,
    super.createdAt,
    required super.lineCount,
  });

  /// Uses API `lineCount` when the server sends it; otherwise [lines].length.
  static int resolveLineCount(
    Map<String, dynamic> order, {
    required List<OrderLineEntity> lines,
  }) {
    final raw = order['lineCount'];
    if (raw is num) return raw.toInt();
    return lines.length;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final order = json['order'] is Map<String, dynamic>
        ? json['order'] as Map<String, dynamic>
        : json;

    final rawLines = order['lines'] as List? ?? [];
    final lines = rawLines
        .map((e) => OrderLineModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return OrderModel(
      id: order['_id']?.toString() ?? order['id']?.toString() ?? '',
      receiptNumber: order['receiptNumber'] as String? ?? '',
      currency: order['currency'] as String? ?? 'NGN',
      subtotalNgn: (order['subtotalNgn'] as num?)?.toInt() ?? 0,
      lines: lines,
      lineCount: resolveLineCount(order, lines: lines),
      paymentProvider: order['paymentProvider'] as String? ?? '',
      paystackReference: order['paystackReference'] as String? ?? '',
      paystackSimulated: order['paystackSimulated'] as bool? ?? false,
      paidAt: tryParseDateTime(order['paidAt']),
      createdAt: tryParseDateTime(order['createdAt']),
    );
  }
}
