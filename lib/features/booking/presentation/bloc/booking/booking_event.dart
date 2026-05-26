import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class GetHireBookings extends BookingEvent {
  const GetHireBookings({this.forceRefresh = false});

  final bool forceRefresh;

  @override
  List<Object?> get props => [forceRefresh];
}

enum ProviderBookingTab { hire, personnel }

class SelectProviderBookingTab extends BookingEvent {
  final ProviderBookingTab tab;

  const SelectProviderBookingTab(this.tab);

  @override
  List<Object?> get props => [tab];
}

class BookingReset extends BookingEvent {
  const BookingReset();
}
