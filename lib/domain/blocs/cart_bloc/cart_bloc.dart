import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/api_client/cart_api_client.dart';
import 'package:online_store/domain/entity/cart.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._cartApiClient) : super(CartInitialState()) {
    on<CartInitializeEvent>((event, emit) async => await _initialize(emit));
    on<CartIncrementCountEvent>(
        (event, emit) async => await _incrementCount(emit));
    on<CartDecrementCountEvent>(
        (event, emit) async => await _decrementCount(emit));
    on<CartDeleteCountEvent>(
        (event, emit) async => await _deleteProductFromBasket(emit));

    add(CartInitializeEvent());
  }

  final CartApiClient _cartApiClient;

  Future<void> _initialize(Emitter<CartState> emit) async {
    if (state is! CartLoadedState) {
      emit(CartLoadingState());
    }
    try {
      final cart = await _cartApiClient.getCartData();
      emit(CartLoadedState(cart: cart));
    } catch (e) {
      emit(CartLoadingErrorState(error: e));
    }
  }

  Future<void> _incrementCount(Emitter<CartState> emit) async {}

  Future<void> _decrementCount(Emitter<CartState> emit) async {}

  Future<void> _deleteProductFromBasket(Emitter<CartState> emit) async {}
}
