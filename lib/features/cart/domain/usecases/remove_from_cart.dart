import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';

class RemoveFromCartUsecase
    implements Usecase<DataState<CartEntity>, CartItemEntity> {
  final CartRepo _cartRepo;

  const RemoveFromCartUsecase(this._cartRepo);

  @override
  Future<DataState<CartEntity>> call({CartItemEntity? params}) {
    return _cartRepo.removeFromCart(params!);
  }
}
