import 'package:equatable/equatable.dart';

abstract class GetProviderServicesEvent extends Equatable {
  final bool forceRefresh;

  const GetProviderServicesEvent({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class GetProviderServices extends GetProviderServicesEvent {
  const GetProviderServices({super.forceRefresh});
}
