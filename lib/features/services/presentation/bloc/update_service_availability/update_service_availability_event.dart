import 'package:equatable/equatable.dart';

abstract class UpdateServiceAvailabilityEvent extends Equatable {
  const UpdateServiceAvailabilityEvent();

  @override
  List<Object?> get props => [];
}

class UpdateServiceAvailability extends UpdateServiceAvailabilityEvent {
  final String serviceId;
  final bool isAvailable;

  const UpdateServiceAvailability({
    required this.serviceId,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [serviceId, isAvailable];
}

class UpdateServiceAvailabilityReset extends UpdateServiceAvailabilityEvent {
  const UpdateServiceAvailabilityReset();
}
