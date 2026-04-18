import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class GetServicesState extends Equatable {
  final List<ServiceEntity>? services;
  final String? errorMessage;
  const GetServicesState({this.services, this.errorMessage});

  @override
  List<Object?> get props => [services, errorMessage];
}

class GetServicesInitial extends GetServicesState {
  const GetServicesInitial();
}

class GetServicesLoading extends GetServicesState {
  const GetServicesLoading();
}

class GetServicesSuccess extends GetServicesState {
  const GetServicesSuccess({required super.services});
}

class GetServicesFailure extends GetServicesState {
  const GetServicesFailure({required super.errorMessage});
}
