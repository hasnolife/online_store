import 'package:json_annotation/json_annotation.dart';
part 'best_seller_entity.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class BestSellerEntity {
  final int id;
  final bool isFavorites;
  final String title;
  final int priceWithoutDiscount;
  final int discountPrice;
  final String picture;

  BestSellerEntity({
    required this.id,
    required this.isFavorites,
    required this.title,
    required this.priceWithoutDiscount,
    required this.discountPrice,
    required this.picture,
  });

  factory BestSellerEntity.fromJson(Map<String, dynamic> json) => _$BestSellerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerEntityToJson(this);
}
