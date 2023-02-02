import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ProductDetailsScreenModel extends ChangeNotifier {
  late final Future<ProductDetails?> _futureDetails;
  late final ProductDetails? _productDetails;

  final _apiClient = ApiClient();

  ProductDetailsScreenModel() {
    _setup();
  }

  Future<ProductDetails?> get futureDetails => _futureDetails;

  ProductDetails? get productDetails => _productDetails;

  int convertColor(String stringColor) {
    return int.parse(stringColor.replaceFirst('#', '0xFF'));
  }

  String intToPrice(int intPrice) {
    String stringPrice = intPrice.toString();
    if (stringPrice.length < 4) {
      return '\$$stringPrice.00';
    }
    for (var i = stringPrice.length; i > 0; i--) {
      if ((i + 1) % 3 == 0) {
        final replaceChar = stringPrice[stringPrice.length - i];
        stringPrice = stringPrice.replaceAll(RegExp(source)
            replaceChar, ',$replaceChar', i);
      }
    }

    return '\$$stringPrice.00';
  }

  void _setup() {
    _futureDetails = _apiClient
        .getProductDetailsData()
        .then((data) => _productDetails = data);
  }
}
