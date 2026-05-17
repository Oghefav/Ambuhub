import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/core/usecase/usecase.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/repository/cart_repo.dart';

class GetCartUsecase implements Usecase<DataState<CartEntity>, void> {
  final CartRepo _cartRepo;

  const GetCartUsecase(this._cartRepo);

  @override
  Future<DataState<CartEntity>> call({void params}) {
    return _cartRepo.getCart();
  }
}
