import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

class MyMethods {
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
    return '\$$stringPrice';
  }

  void showCart(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.cart);
  }

  void closeRoute(BuildContext context) {
    Navigator.of(context).pop();
  }
}
