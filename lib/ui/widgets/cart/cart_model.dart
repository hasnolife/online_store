import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/cart.dart';

class CartModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late final Future<Cart?> _futureCartData;
  Future<Cart?> get futureCartData => _futureCartData;
  late final Cart _cartData;
  Cart get cartData => _cartData;

  CartModel() {
    _setup();
  }

  void incrementCount() {}
  void decrementCount() {}

void _setup() {
  _futureCartData = _apiClient.getCartData().then((data) => _cartData = data!);
}
}