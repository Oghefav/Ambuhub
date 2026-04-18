import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class AddServiceState extends Equatable {
  final ServiceEntity? service;
  final String? errorMessage;
  const AddServiceState({this.service, this.errorMessage});

  @override
  List<Object?> get props => [service, errorMessage];
}

class AddServiceInitial extends AddServiceState {
  const AddServiceInitial();
}

class AddServiceLoading extends AddServiceState {
  const AddServiceLoading();
}

class AddServiceSuccess extends AddServiceState {
  const AddServiceSuccess({required super.service});
}

class AddServiceError extends AddServiceState {
  const AddServiceError({required super.errorMessage});
}
