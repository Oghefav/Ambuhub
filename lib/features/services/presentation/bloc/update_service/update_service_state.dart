import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateServiceState extends Equatable {
  final ServiceEntity? service;
  final String? errorMessage;
  const UpdateServiceState({this.service, this.errorMessage});

  @override
  List<Object?> get props => [service, errorMessage];
}

class UpdateServiceInitial extends UpdateServiceState {
  const UpdateServiceInitial();
}

class UpdateServiceLoading extends UpdateServiceState {
  const UpdateServiceLoading();
}

class UpdateServiceSuccess extends UpdateServiceState {
  const UpdateServiceSuccess({required super.service});
}

class UpdateServiceError extends UpdateServiceState {
  const UpdateServiceError({required super.errorMessage});
}
