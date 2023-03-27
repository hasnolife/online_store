import 'package:online_store/configuration/configuration.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/cart.dart';

class CartApiClient extends ApiClient<Cart> {
  @override
  Cart convertJsonToData(Map<String, dynamic> json) {
    return Cart.fromJson(json);
  }

  Future<Cart> getCartData() async {
    return await getData(Configuration.cartApi);
  }
}
