import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:ambuhub/features/booking/presentation/bloc/booking/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingInitial());
}
