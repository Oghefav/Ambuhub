import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

class HireCheckoutUsecase
    implements Usecase<DataState<OrderEntity>, HireParams> {
  final OrderRepo _orderRepo;

  const HireCheckoutUsecase(this._orderRepo);

  @override
  Future<DataState<OrderEntity>> call({HireParams? params}) {
    return _orderRepo.hireCheckout(params!);
  }
}
