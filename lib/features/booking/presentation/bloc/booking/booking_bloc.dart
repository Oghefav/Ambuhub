import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:ambuhub/features/booking/domain/usecases/get_provider_hire_bookings.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetProviderHireBookingsUsecase _getProviderHireBookingsUsecase;

  List<HireBookingEntity>? _hireBookingsCache;

  BookingBloc(this._getProviderHireBookingsUsecase) : super(const BookingInitial()) {
    on<GetHireBookings>(_onGetHireBookings);
    on<SelectProviderBookingTab>(_onSelectTab);
    on<BookingReset>(_onReset);
  }

  void _onSelectTab(
    SelectProviderBookingTab event,
    Emitter<BookingState> emit,
  ) {
    emit(BookingLoaded(
      hireBookings: state.hireBookings,
      selectedTab: event.tab,
      hasLoaded: state.hasLoaded,
    ));
  }

  void _onReset(BookingReset event, Emitter<BookingState> emit) {
    _hireBookingsCache = null;
    emit(const BookingInitial());
  }

  Future<void> _onGetHireBookings(
    GetHireBookings event,
    Emitter<BookingState> emit,
  ) async {
    if (!event.forceRefresh && _hireBookingsCache != null) {
      emit(BookingLoaded(
        hireBookings: _hireBookingsCache!,
        selectedTab: state.selectedTab,
        hasLoaded: true,
      ));
      return;
    }

    emit(BookingLoaded(
      hireBookings: state.hireBookings,
      selectedTab: state.selectedTab,
      isLoading: true,
      hasLoaded: state.hasLoaded,
    ));

    final dataState = await _getProviderHireBookingsUsecase();
    if (dataState is DataSuccess) {
      _hireBookingsCache = dataState.data ?? [];
      emit(BookingLoaded(
        hireBookings: _hireBookingsCache!,
        selectedTab: state.selectedTab,
        hasLoaded: true,
      ));
      return;
    }

    emit(BookingFailure(
      errorMessage: dataState.errorMessage,
      hireBookings: state.hireBookings,
      selectedTab: state.selectedTab,
      hasLoaded: true,
    ));
  }
}
