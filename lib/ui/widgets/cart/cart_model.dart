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

  String intToPrice(int intPrice, bool double) {
    String stringPrice = intPrice.toString();
    if (stringPrice.length < 4) {
      return '\$$stringPrice.00';
    }

    var newPrice = stringPrice.split('');
    final counts = stringPrice.length ~/ 3;

    for (var i = 0; i < counts; i++) {
      newPrice.insert(stringPrice.length - (i + 1) * 3, ',');
    }

    stringPrice = newPrice.join('');
    if (double) {
      return '\$$stringPrice.00';
    }
    return '\$$stringPrice us';
  }

void _setup() {
  _futureCartData = _apiClient.getCartData().then((data) => _cartData = data!);
}
}