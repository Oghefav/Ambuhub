import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class GetProviderServicesState extends Equatable {
  final List<ServiceEntity>? services;
  final String? errorMessage;

  const GetProviderServicesState({this.services, this.errorMessage});

  @override
  List<Object?> get props => [services, errorMessage];
}

class GetProviderServicesInitial extends GetProviderServicesState {
  const GetProviderServicesInitial();
}

class GetProviderServicesLoading extends GetProviderServicesState {
  const GetProviderServicesLoading();
}

class GetProviderServicesSuccess extends GetProviderServicesState {
  const GetProviderServicesSuccess({required super.services});
}

class GetProviderServicesFailure extends GetProviderServicesState {
  const GetProviderServicesFailure({required super.errorMessage});
}
