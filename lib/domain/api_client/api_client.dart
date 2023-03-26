import 'dart:convert';
import 'dart:io';

import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/entity/cart.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ApiClient {
  final _apiClient = HttpClient();

  Future<HomeStoreData> getHomeStoreData() async {
      final url = Uri.parse(Configuration.homeStoreApi);
      final request = await _apiClient.getUrl(url);
      final response = await request.close();
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final jsonString = jsonStrings.join();

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final HomeStoreData homeStoreData = HomeStoreData.fromJson(json);
      return homeStoreData;
  }

  // Future<String> tryToLoadImage(String imageUrl) async {
  //   try {
  //     final url = Uri.parse(imageUrl);
  //     final request = await _apiClient.getUrl(url);
  //     final response = await request.close();
  //     final statusCode = response.statusCode;
  //     if (response.statusCode != 200) return Configuration.crashImage;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return imageUrl;
  // }

  Future<ProductDetails> getProductDetailsData() async {
    final url = Uri.parse(Configuration.detailsApi);
    final request = await _apiClient.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final ProductDetails productDetails = ProductDetails.fromJson(json);

    return productDetails;
  }

  Future<Cart> getCartData() async {
    final url = Uri.parse(Configuration.cartApi);
    final request = await _apiClient.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final Cart cart = Cart.fromJson(json);

    return cart;
  }
}
