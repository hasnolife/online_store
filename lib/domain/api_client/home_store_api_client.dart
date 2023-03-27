import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/home_store_data.dart';

class HomeStoreApiClient extends ApiClient<HomeStoreData> {
  @override
  HomeStoreData convertJsonToData(Map<String, dynamic> json) {
    return HomeStoreData.fromJson(json);
  }

  Future<HomeStoreData> getHomeStoreData() async {
    return await getData(Configuration.homeStoreApi);
  }
}
