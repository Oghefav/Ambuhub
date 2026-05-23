import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/features/order/domain/entities/order_line_entity.dart';

/// Sale: `2 × ₦50,000`. Hire/book: adds billable units and pricing period.
String formatOrderLineQuantityDetail(OrderLineEntity item) {
  final base = '${item.quantity} × ${formatCurrency(item.unitPriceNgn)}';
  final listingType = item.lineKind.toLowerCase();

  if (listingType == 'sale') return base;

  if (listingType == 'hire' || listingType == 'book') {
    final units = item.hireBillableUnits;
    final period = item.pricingPeriod?.trim();
    if (units != null && period != null && period.isNotEmpty) {
      return '$base × $units $period';
    }
    if (units != null) return '$base × $units';
    if (period != null && period.isNotEmpty) return '$base × $period';
  }

  return base;
}
