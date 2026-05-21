import 'package:equatable/equatable.dart';

class HireParams extends Equatable {
  final String serviceId;
  final int quantity;
  final DateTime hireStart;
  final DateTime hireEnd;

  const HireParams({
    required this.serviceId,
    required this.quantity,
    required this.hireStart,
    required this.hireEnd,
  });

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'quantity': quantity,
        'hireStart': hireStart.toUtc().toIso8601String(),
        'hireEnd': hireEnd.toUtc().toIso8601String(),
      };

  @override
  List<Object?> get props => [serviceId, quantity, hireStart, hireEnd];
}
