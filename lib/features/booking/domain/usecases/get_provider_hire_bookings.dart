import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/booking/domain/entities/hire_booking_entity.dart';
import 'package:ambuhub/features/booking/domain/repository/booking_repo.dart';

class GetProviderHireBookingsUsecase
    implements Usecase<DataState<List<HireBookingEntity>>, void> {
  final BookingRepo _repo;

  const GetProviderHireBookingsUsecase(this._repo);

  @override
  Future<DataState<List<HireBookingEntity>>> call({void params}) {
    return _repo.getProviderHireBookings();
  }
}
