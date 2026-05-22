import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String receiptNumber;
  final String currency;
  final int subtotalNgn;
  final List<OrderLineEntity> lines;
  final String paymentProvider;
  final String paystackReference;
  final bool paystackSimulated;
  final DateTime? paidAt;
  final DateTime? createdAt;
  final int lineCount;

  const OrderEntity({
    required this.id,
    required this.receiptNumber,
    required this.currency,
    required this.subtotalNgn,
    required this.lines,
    required this.paymentProvider,
    required this.paystackReference,
    required this.paystackSimulated,
    this.paidAt,
    this.createdAt,
    required this.lineCount,
  });

  OrderLineEntity? get primaryLine =>
      lines.isNotEmpty ? lines.first : null;

  @override
  List<Object?> get props => [
        id,
        receiptNumber,
        currency,
        subtotalNgn,
        lines,
        paymentProvider,
        paystackReference,
        paystackSimulated,
        paidAt,
        createdAt,
        lineCount,
      ];
}
