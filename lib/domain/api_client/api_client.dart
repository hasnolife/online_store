import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ApiClient {
  final _apiClient = HttpClient();

  Future<HomeStoreData?> getHomeStoreData() async {
    try {
      final url = Uri.parse(Configuration.homeStoreApi);
      final request = await _apiClient.getUrl(url);
      final response = await request.close();
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final jsonString = jsonStrings.join();

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final HomeStoreData homeStoreData = HomeStoreData.fromJson(json);
      print(' ');
      return homeStoreData;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ProductDetails?> getProductDetailsData() async {
    try {
      final url = Uri.parse(Configuration.detailsApi);
      final request = await _apiClient.getUrl(url);
      final response = await request.close();
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final jsonString = jsonStrings.join();

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final ProductDetails productDetails = ProductDetails.fromJson(json);

      return productDetails;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }


}
