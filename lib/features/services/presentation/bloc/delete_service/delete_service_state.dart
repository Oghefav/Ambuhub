import 'package:equatable/equatable.dart';

abstract class DeleteServiceState extends Equatable {
  const DeleteServiceState();

  @override
  List<Object?> get props => [];
}

class DeleteServiceInitial extends DeleteServiceState {
  const DeleteServiceInitial();
}

class DeleteServiceLoading extends DeleteServiceState {
  const DeleteServiceLoading();
}

class DeleteServiceSuccess extends DeleteServiceState {
  const DeleteServiceSuccess();
}

class DeleteServiceError extends DeleteServiceState {
  final String? errorMessage;

  const DeleteServiceError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
