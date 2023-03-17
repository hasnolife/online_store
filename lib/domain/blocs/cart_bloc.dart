import 'package:bloc/bloc.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/cart.dart';

class CartState {
  final Cart? cart;

//<editor-fold desc="Data Methods">
  const CartState({
    required this.cart,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartState &&
          runtimeType == other.runtimeType &&
          cart == other.cart);

  @override
  int get hashCode => cart.hashCode;

  @override
  String toString() {
    return 'CartState{ cart: $cart }';
  }

  CartState copyWith({
    Cart? cart,
  }) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

//</editor-fold>
}

abstract class CartEvent {}

class CartInitializeEvent extends CartEvent {}

class CartIncrementCountEvent extends CartEvent {}

class CartDecrementCountEvent extends CartEvent {}

class CartDeleteCountEvent extends CartEvent {}

class CartBloc extends Bloc<CartEvent, CartState> {
  final _apiClient = ApiClient();

  CartBloc() : super(const CartState(cart: null)) {
    on<CartInitializeEvent>((event, emit) async {
      await _initialize(emit);
    });
    on<CartIncrementCountEvent>((event, emit) async {
      await _incrementCount(emit);
    });
    on<CartDecrementCountEvent>((event, emit) async {
      await _decrementCount(emit);
    });
    on<CartDeleteCountEvent>((event, emit) async {
      await _deleteProductFromBasket(emit);
    });

    add(CartInitializeEvent());
  }

  Future<void> _initialize(Emitter<CartState> emit) async {
    final cart = await _apiClient.getCartData();
    final newState = state.copyWith(cart: cart);
    emit(newState);
  }

  Future<void> _incrementCount(Emitter<CartState> emit) async {}

  Future<void> _decrementCount(Emitter<CartState> emit) async {}

  Future<void> _deleteProductFromBasket(Emitter<CartState> emit) async {}
}
