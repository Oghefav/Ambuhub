import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';

class AddToCartUsecase implements Usecase<DataState<CartEntity>, CartItemEntity> {
  final CartRepo _cartRepo;

  const AddToCartUsecase(this._cartRepo);

  @override
  Future<DataState<CartEntity>> call({CartItemEntity? params}) {
    return _cartRepo.addToCart(params!);
  }
}
