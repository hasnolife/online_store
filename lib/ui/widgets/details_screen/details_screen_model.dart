import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ProductDetailsScreenModel extends ChangeNotifier {
  late final Future<ProductDetails?> _futureDetails;
  late final ProductDetails? _productDetails;

  final _apiClient = ApiClient();
  ProductDetailsScreenModel() {
    _futureDetails = _apiClient.getProductDetailsData().then((data) => _productDetails = data);
  }
  Future<ProductDetails?> get futureDetails => _futureDetails;
  ProductDetails? get productDetails => _productDetails;
}