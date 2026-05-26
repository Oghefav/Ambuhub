import 'package:ambuhub/features/booking/domain/entities/hire_booking_customer_entity.dart';
import 'package:equatable/equatable.dart';

class HireBookingEntity extends Equatable {
  final String orderId;
  final String receiptNumber;
  final DateTime? paidAt;
  final String serviceId;
  final String listingTitle;
  final DateTime? hireStart;
  final DateTime? hireEnd;
  final String pricingPeriod;
  final int hireBillableUnits;
  final int quantity;
  final int lineTotalNgn;
  final HireBookingCustomerEntity customer;

  const HireBookingEntity({
    required this.orderId,
    required this.receiptNumber,
    required this.serviceId,
    required this.listingTitle,
    required this.pricingPeriod,
    required this.hireBillableUnits,
    required this.quantity,
    required this.lineTotalNgn,
    required this.customer,
    this.paidAt,
    this.hireStart,
    this.hireEnd,
  });

  bool get isActive {
    final end = hireEnd;
    if (end == null) return false;
    return end.isAfter(DateTime.now());
  }

  @override
  List<Object?> get props => [
        orderId,
        receiptNumber,
        paidAt,
        serviceId,
        listingTitle,
        hireStart,
        hireEnd,
        pricingPeriod,
        hireBillableUnits,
        quantity,
        lineTotalNgn,
        customer,
      ];
}
