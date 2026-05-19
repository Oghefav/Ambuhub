import 'package:ambuhub/core/resources/data_state.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/change_cart_item_quantity.dart';
import 'package:ambuhub/features/cart/domain/usecases/get_cart.dart';
import 'package:ambuhub/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase _getCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;
  final ChangeCartItemQuantityUsecase _changeCartItemQuantityUsecase;
  CartBloc(
    this._getCartUsecase,
    this._addToCartUsecase,
    this._removeFromCartUsecase,
    this._changeCartItemQuantityUsecase,
  ) : super(const CartInitial()) {
    on<GetCart>(_onGetCart);
    on<AddCartItem>(_onAddCartItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<CartItemDecrement>(_onCartItemDecrement);
    on<CartItemIncrement>(_onCartItemIncrement);
  }

  Future<void> _onGetCart(GetCart event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final dataState = await _getCartUsecase();

    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage,));
    }
  }

  Future<void> _onAddCartItem(
    AddCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(
      CartLoading(
        cart: state.cart,
        pendingServiceId: event.item?.service.id,
        isAddingToCart: true,
      ),
    );
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
    emit(CartLoading(cart: state.cart, pendingServiceId: event.item!.service.id));
    final dataState = await _removeFromCartUsecase(params: event.item);

    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }

  Future<void> _onCartItemDecrement(
    CartItemDecrement event,
    Emitter<CartState> emit,
  ) async {
    final CartItemEntity cartItem = state.cart!.items.firstWhere(
      (element) => event.item!.service.id == element.service.id,
    );
    final newQuantity = cartItem.quantity - 1;
    emit( CartLoading(cart: state.cart, pendingServiceId: event.item!.service.id));
    final dataState = await _changeCartItemQuantityUsecase(
      params: (newQuantity, cartItem.service.id),
    );
    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }

  Future<void> _onCartItemIncrement(
    CartItemIncrement event,
    Emitter<CartState> emit,
  ) async {
    final CartItemEntity cartItem = state.cart!.items.firstWhere(
      (element) => event.item!.service.id == element.service.id,
    );
    final newQuantity = cartItem.quantity + 1;
    emit( CartLoading(cart: state.cart, pendingServiceId: event.item!.service.id));
    final dataState = await _changeCartItemQuantityUsecase(
      params: (newQuantity, cartItem.service.id),
    );
    if (dataState is DataSuccess) {
      emit(CartSuccess(cart: dataState.data!));
    } else {
      emit(CartFailure(errorMessage: dataState.errorMessage, cart: state.cart));
    }
  }
}
