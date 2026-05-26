import 'package:equatable/equatable.dart';

abstract class DeleteServiceEvent extends Equatable {
  const DeleteServiceEvent();

  @override
  List<Object?> get props => [];
}

class DeleteService extends DeleteServiceEvent {
  final String serviceId;

  const DeleteService(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

class DeleteServiceReset extends DeleteServiceEvent {
  const DeleteServiceReset();
}
