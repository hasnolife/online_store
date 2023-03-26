part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {

  final Cart cart;
  @override
  List<Object> get props => [];

  const CartLoadedState({
    required this.cart,
  });
}

class CartLoadingErrorState extends CartState {
  const CartLoadingErrorState({
    this.error,
  });

  final Object? error;

  @override
  List<Object> get props => [];
}
