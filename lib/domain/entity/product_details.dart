import 'package:json_annotation/json_annotation.dart';
part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails {
  @JsonKey(name: "CPU")
  final String cpu;
  final String camera;
  final List<String> capacity;
  final List<String> color;
  final String id;
  final List<String> images;
  final bool isFavorites;
  final int price;
  final double rating;
  final String sd;
  final String ssd;
  final String title;

  ProductDetails(this.cpu, this.camera, this.capacity, this.color, this.id, this.images, this.isFavorites, this.price, this.rating, this.sd, this.ssd, this.title);

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}

