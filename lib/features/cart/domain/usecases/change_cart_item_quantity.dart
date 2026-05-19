import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';


class ChangeCartItemQuantityUsecase implements Usecase<DataState<CartEntity>, (int, String)> {
  final CartRepo _cartRepo;
  const ChangeCartItemQuantityUsecase(this._cartRepo);

  @override
  Future<DataState<CartEntity>> call({(int, String)? params}) {
    final (quantity, serviceId) = params!;
    return _cartRepo.changeCartItemQuantity(quantity, serviceId);
  }
}