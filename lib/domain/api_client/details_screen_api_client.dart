import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

class DetailsScreenApiClient extends ApiClient<ProductDetails> {
  @override
  ProductDetails convertJsonToData(Map<String, dynamic> json) {
    return ProductDetails.fromJson(json);
  }

  Future<ProductDetails> getProductDetailsData() async {
    return await getData(Configuration.detailsApi);
  }
}
