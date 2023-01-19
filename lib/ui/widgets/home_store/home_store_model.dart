import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/home_store_api_client.dart';
import 'package:online_store/domain/entity/home_store_data.dart';

class HomeStoreModel extends ChangeNotifier {
  late final Future<HomeStoreData?> _futureData;
  late final HomeStoreData? _data;

  HomeStoreData? get data => _data;
  Future<HomeStoreData?> get futureData => _futureData;
  HomeStoreModel() {
    _futureData = HomeStoreApiClient().getHomeStoreData().then((value) => _data = value);
    // _data = await HomeStoreApiClient().getHomeStoreData();
  }
}