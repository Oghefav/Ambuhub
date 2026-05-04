import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateServiceEvent extends Equatable {
  final ServiceParams? service;

  const UpdateServiceEvent({this.service});

  @override
  List<Object?> get props => [service];
}

class UpdateService extends UpdateServiceEvent {
  const UpdateService({required super.service});
}

class UpdateServiceReset extends UpdateServiceEvent {
  const UpdateServiceReset();
}
