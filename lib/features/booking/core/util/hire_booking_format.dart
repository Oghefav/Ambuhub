import 'package:ambuhub/core/utililty/app_formatter.dart';
import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';

String formatHireBookingPeriodSummary(HireBookingEntity booking) {
  final period = capitalizeFirstLetter(booking.pricingPeriod.trim());
  return 'Period: $period · ${booking.hireBillableUnits} units · Qty ${booking.quantity}';
}

String formatHireBookingReceiptLine(HireBookingEntity booking) {
  final orderShort = booking.orderId.length > 8
      ? booking.orderId.substring(booking.orderId.length - 8)
      : booking.orderId;
  return 'Receipt ${booking.receiptNumber} · Order $orderShort';
}

String? formatHireBookingStart(HireBookingEntity booking) {
  final label = formatDateTimeShort(booking.hireStart);
  if (label.isEmpty) return null;
  return 'Starts: $label';
}

String? formatHireBookingEnd(HireBookingEntity booking) {
  final label = formatDateTimeShort(booking.hireEnd);
  if (label.isEmpty) return null;
  return 'Ends: $label';
}
