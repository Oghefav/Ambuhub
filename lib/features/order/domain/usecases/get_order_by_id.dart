import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/domain/repository/order_repo.dart';

class GetOrderByIdUsecase implements Usecase<DataState<OrderEntity>, String> {
  final OrderRepo _repo;

  const GetOrderByIdUsecase(this._repo);

  @override
  Future<DataState<OrderEntity>> call({String? params}) {
    return _repo.getOrderById(params!);
  }
}
