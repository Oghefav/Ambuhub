import 'package:ambuhub/features/services/domain/enitities/service_params.dart';
import 'package:equatable/equatable.dart';

abstract class AddServiceEvent extends Equatable {
  final ServiceParams service;

  const AddServiceEvent({required this.service});

  @override
  List<Object> get props => [service];
}

class AddService extends AddServiceEvent {
  const AddService({required super.service});
}
