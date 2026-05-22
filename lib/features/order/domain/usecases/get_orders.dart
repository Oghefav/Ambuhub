import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

class GetOrdersUsecase
    implements Usecase<DataState<List<OrderEntity>>, void> {
  final OrderRepo _repo;

  const GetOrdersUsecase(this._repo);

  @override
  Future<DataState<List<OrderEntity>>> call({void params}) {
    return _repo.getOrders();
  }
}
