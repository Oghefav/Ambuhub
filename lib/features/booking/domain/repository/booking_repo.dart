import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';

abstract class BookingRepo {
  Future<DataState<List<HireBookingEntity>>> getProviderHireBookings();
}
