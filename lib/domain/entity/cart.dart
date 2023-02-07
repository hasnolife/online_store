import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  final List<CartProduct> basket;
  final String delivery;
  final String id;
  final int total;

  Cart(this.basket, this.delivery, this.id, this.total);

  factory Cart.fromJson(Map<String, dynamic> json) =>
      _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

}

@JsonSerializable()
class CartProduct {
  final int id;
  final String images;
  final int price;
  final String title;

  CartProduct(this.id, this.images, this.price, this.title);

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}