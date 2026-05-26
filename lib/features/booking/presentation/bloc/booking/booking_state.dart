import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  final List<HireBookingEntity> hireBookings;
  final ProviderBookingTab selectedTab;
  final String? errorMessage;
  final bool hasLoaded;
  final bool isLoading;

  const BookingState({
    this.hireBookings = const [],
    this.selectedTab = ProviderBookingTab.hire,
    this.errorMessage,
    this.hasLoaded = false,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        hireBookings,
        selectedTab,
        errorMessage,
        hasLoaded,
        isLoading,
      ];
}

class BookingInitial extends BookingState {
  const BookingInitial();
}

class BookingLoaded extends BookingState {
  const BookingLoaded({
    super.hireBookings,
    super.selectedTab,
    super.errorMessage,
    super.hasLoaded,
    super.isLoading,
  });
}

class BookingFailure extends BookingState {
  const BookingFailure({
    required super.errorMessage,
    super.hireBookings,
    super.selectedTab,
    super.hasLoaded,
    super.isLoading,
  });
}
