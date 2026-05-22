import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/booking/domain/entities/booking_checkout_params.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

class BookingCheckoutUsecase
    implements Usecase<DataState<OrderEntity>, BookingCheckoutParams> {
  final OrderRepo _orderRepo;

  const BookingCheckoutUsecase(this._orderRepo);

  @override
  Future<DataState<OrderEntity>> call({BookingCheckoutParams? params}) {
    return _orderRepo.bookingCheckout(params!);
  }
}
