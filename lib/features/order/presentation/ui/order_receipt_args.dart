import 'package:ambuhub/features/order/domain/entities/order_entity.dart';

/// Navigation args for [OrderReceiptScreen].
class OrderReceiptArgs {
  final String orderId;
  final OrderEntity? preview;

  const OrderReceiptArgs({
    required this.orderId,
    this.preview,
  });

  factory OrderReceiptArgs.fromOrder(OrderEntity order) {
    return OrderReceiptArgs(
      orderId: order.id,
      preview: order,
    );
  }

  /// Checkout responses include line items; list summaries often do not.
  bool get hasLines => preview != null && preview!.lines.isNotEmpty;
}
