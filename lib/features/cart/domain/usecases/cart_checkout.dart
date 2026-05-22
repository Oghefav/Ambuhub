import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

class CartCheckoutUsecase
    implements Usecase<DataState<OrderEntity>,void> {
  final OrderRepo _orderRepo;

  const CartCheckoutUsecase(this._orderRepo);

  @override
  Future<DataState<OrderEntity>> call({void params}) {
    return _orderRepo.cartCheckout();
  } 
}
