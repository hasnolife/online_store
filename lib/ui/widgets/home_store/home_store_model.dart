import 'package:flutter/material.dart';
import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

class HomeStoreModel extends ChangeNotifier {
  late final Future<HomeStoreData?> _futureData;
  late final HomeStoreData? _data;
  final _apiClient = ApiClient();
  bool isFilterOpen = false;
  int _selectedCategory = 0;

  set selectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  int get selectedCategory => _selectedCategory;

  String _productImage = Configuration.crashImage;

  String get productImage => _productImage;

  Future<void> imageLoader(String imageUrl) async {
    _productImage = await _apiClient.tryToLoadImage(imageUrl);
  }

  HomeStoreData? get data => _data;

  Future<HomeStoreData?> get futureData => _futureData;

  HomeStoreModel() {
    _setup();
  }

  void toggleFavorite(BestSellerEntity product) {
    product.isFavorites = !product.isFavorites;
    notifyListeners();
  }

  void _checkProductImage(bestSellers) {
    for (var product in bestSellers) {
      _apiClient.tryToLoadImage(product.picture).then((verifiedUrl) {
        if (product.picture == verifiedUrl) return;
        product.picture = verifiedUrl;
        notifyListeners();
      });
    }
  }

  void _setup() {
    _futureData = _apiClient.getHomeStoreData().then((data) {
      _checkProductImage(data?.bestSeller);
      return _data = data;
    });
  }

  void closeFilterDialog(context) {
    if (isFilterOpen == true) {
      Navigator.of(context).pop();
      isFilterOpen = false;
    }
  }

  void openFilterDialog(PersistentBottomSheetController<dynamic> sheet) {
    if (isFilterOpen == true) {
      return;
    }
    sheet;
    isFilterOpen = true;
  }

  void showDetails(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.details);
  }
}
