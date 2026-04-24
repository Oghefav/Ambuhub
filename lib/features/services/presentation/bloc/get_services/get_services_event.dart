import 'package:equatable/equatable.dart';

abstract class GetServicesEvent extends Equatable {
  final String? categorySlug;
  const GetServicesEvent({this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}

class GetServices extends GetServicesEvent {
  const GetServices();
}
class GetServiceInfo extends GetServicesEvent {
  const GetServiceInfo({required super.categorySlug});
}
