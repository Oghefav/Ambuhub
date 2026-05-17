import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/get_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase _getCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;

  CartBloc(
    this._getCartUsecase,
    this._addToCartUsecase,
    this._removeFromCartUsecase,
  ) : super(const CartInitial()) {
    on<GetCart>(_onGetCart);
    on<AddCartItem>(_onAddCartItem);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  Future<void> _onGetCart(GetCart event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: state.cart));
    final dataState = await _getCartUsecase();

    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }

  Future<void> _onAddCartItem(AddCartItem event, Emitter<CartState> emit) async {
    emit(CartLoading(cart: state.cart));
    final dataState = await _addToCartUsecase(params: event.item);

    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }

  Future<void> _onRemoveCartItem(
    RemoveCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading(cart: state.cart));
    final dataState = await _removeFromCartUsecase(params: event.item);

    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }
}
