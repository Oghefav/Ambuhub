import 'package:equatable/equatable.dart';

abstract class GetServicesEvent extends Equatable {
  const GetServicesEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends GetServicesEvent {
  const GetServices();
}
