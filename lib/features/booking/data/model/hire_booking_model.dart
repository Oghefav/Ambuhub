import 'package:ambuhub/core/utililty/locale_display_utils.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_customer_entity.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';

class HireBookingCustomerModel extends HireBookingCustomerEntity {
  const HireBookingCustomerModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
  });

  factory HireBookingCustomerModel.fromJson(Map<String, dynamic> json) {
    return HireBookingCustomerModel(
      id: (json['id'] ?? json['_id']).toString(),
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }
}

class HireBookingModel extends HireBookingEntity {
  const HireBookingModel({
    required super.orderId,
    required super.receiptNumber,
    required super.serviceId,
    required super.listingTitle,
    required super.pricingPeriod,
    required super.hireBillableUnits,
    required super.quantity,
    required super.lineTotalNgn,
    required super.customer,
    super.paidAt,
    super.hireStart,
    super.hireEnd,
  });

  factory HireBookingModel.fromJson(Map<String, dynamic> json) {
    final customerJson = json['customer'];
    return HireBookingModel(
      orderId: (json['orderId'] ?? json['_id']).toString(),
      receiptNumber: json['receiptNumber']?.toString() ?? '',
      paidAt: tryParseDateTime(json['paidAt']),
      serviceId: json['serviceId']?.toString() ?? '',
      listingTitle: json['listingTitle']?.toString() ?? '',
      hireStart: tryParseDateTime(json['hireStart']),
      hireEnd: tryParseDateTime(json['hireEnd']),
      pricingPeriod: json['pricingPeriod']?.toString() ?? '',
      hireBillableUnits: (json['hireBillableUnits'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      lineTotalNgn: (json['lineTotalNgn'] as num?)?.toInt() ?? 0,
      customer: customerJson is Map<String, dynamic>
          ? HireBookingCustomerModel.fromJson(customerJson)
          : const HireBookingCustomerModel(
              id: '',
              firstName: '',
              lastName: '',
              email: '',
              phone: '',
            ),
    );
  }
}
