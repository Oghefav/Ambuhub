import 'package:equatable/equatable.dart';

class HireEntity extends Equatable {
  final String id;
  final String serviceId;
  final int quantity;
  final DateTime hireStart;
  final DateTime hireEnd;

  const HireEntity({
    required this.id,
    required this.serviceId,
    required this.quantity,
    required this.hireStart,
    required this.hireEnd,
  });

  @override
  List<Object?> get props => [id, serviceId, quantity, hireStart, hireEnd];
}
