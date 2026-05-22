import 'package:equatable/equatable.dart';

class BookingCheckoutParams extends Equatable {
  final String serviceId;
  final DateTime bookingStart;
  final DateTime bookingEnd;

  const BookingCheckoutParams({
    required this.serviceId,
    required this.bookingStart,
    required this.bookingEnd,
  });

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'bookingStart': bookingStart.toUtc().toIso8601String(),
        'bookingEnd': bookingEnd.toUtc().toIso8601String(),
      };

  @override
  List<Object?> get props => [serviceId, bookingStart, bookingEnd];
}
