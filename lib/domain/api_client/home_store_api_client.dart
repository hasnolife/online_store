import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/entity/home_store_data.dart';

class HomeStoreApiClient {
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
  }
}
