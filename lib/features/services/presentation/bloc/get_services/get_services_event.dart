import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:equatable/equatable.dart';

abstract class GetServicesEvent extends Equatable {
  final String? categorySlug;
  final ServiceEntity? service;
  const GetServicesEvent({this.categorySlug, this.service});

  @override
  List<Object?> get props => [categorySlug, service];
}

class GetServices extends GetServicesEvent {
  const GetServices();
}
class GetServiceInfo extends GetServicesEvent {
  const GetServiceInfo({required super.categorySlug});
}


