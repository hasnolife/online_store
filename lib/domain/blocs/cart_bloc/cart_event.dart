part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartInitializeEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartIncrementCountEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartDecrementCountEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartDeleteCountEvent extends CartEvent {
  @override
  List<Object> get props => [];
}