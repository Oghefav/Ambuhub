import 'package:equatable/equatable.dart';

class UpdateServiceAvailabilityParams extends Equatable {
  final String serviceId;
  final bool isAvailable;

  const UpdateServiceAvailabilityParams({
    required this.serviceId,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [serviceId, isAvailable];
}
