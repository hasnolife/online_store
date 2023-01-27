import 'package:flutter/material.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

class HomeStoreModel extends ChangeNotifier {
  late final Future<HomeStoreData?> _futureData;
  late final HomeStoreData? _data;

  HomeStoreData? get data => _data;
  Future<HomeStoreData?> get futureData => _futureData;
  HomeStoreModel() {
    _futureData = ApiClient().getHomeStoreData().then((value) => _data = value);
    // _data = await HomeStoreApiClient().getHomeStoreData();
  }

  void showDetails(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.details);
  }

}
