import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ProductDetailsScreenModel extends ChangeNotifier {
  late final Future<ProductDetails?> _futureDetails;
  late final ProductDetails? _productDetails;
  String selectedCategory = 'Shop';
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

    var newPrice = stringPrice.split('');
    final counts = stringPrice.length ~/ 3;

    for (var i = 0; i < counts; i++) {
      newPrice.insert(stringPrice.length - (i + 1) * 3, ',');
    }

    stringPrice = newPrice.join('');

    return '\$$stringPrice.00';
  }

  void favoriteToggle() {
    _productDetails?.isFavorites = !_productDetails!.isFavorites;
    notifyListeners();
  }

  void changeSelectedCategory(String categoryName) {
    if (selectedCategory == categoryName) return;
    selectedCategory = categoryName;
    notifyListeners();
  }

  void _setup() {
    _futureDetails = _apiClient
        .getProductDetailsData()
        .then((data) => _productDetails = data);
  }
}
