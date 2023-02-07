import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

class ProductDetailsScreenModel extends ChangeNotifier {
  late final Future<ProductDetails?> _futureDetails;
  late final ProductDetails? _productDetails;
  String selectedCategory = 'Shop';
  int selectedColorIndex = 0;
  int selectedCapacityIndex = 0;



  final _apiClient = ApiClient();

  ProductDetailsScreenModel() {
    _setup();
  }

  Future<ProductDetails?> get futureDetails => _futureDetails;

  ProductDetails? get productDetails => _productDetails;

  int convertColor(String stringColor) {
    return int.parse(stringColor.replaceFirst('#', '0xFF'));
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

  void changeColor(String color) {
    if (_productDetails!.color[selectedColorIndex] == color) return;
    selectedColorIndex = _productDetails!.color.indexOf(color);
    notifyListeners();
  }

  void changeCapacity(String capacity) {
    if (_productDetails!.capacity[selectedCapacityIndex] == capacity) return;
    selectedCapacityIndex = _productDetails!.capacity.indexOf(capacity);
    notifyListeners();
  }



  void _setup() async {
    _futureDetails = _apiClient
        .getProductDetailsData()
        .then((data) => _productDetails = data);
    // selectedColor = _productDetails!.color.first;
  }
}
