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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetails &&
          runtimeType == other.runtimeType &&
          isFavorites == other.isFavorites;

  @override
  int get hashCode => isFavorites.hashCode;

  ProductDetails(this.cpu, this.camera, this.capacity, this.color, this.id,
      this.images, this.price, this.rating, this.sd, this.ssd, this.title,
      {required this.isFavorites});

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);

  ProductDetails copyWith({
    bool? isFavorites,
  }) {
    return ProductDetails(
        isFavorites: isFavorites ?? this.isFavorites,
        cpu,
        camera,
        capacity,
        color,
        id,
        images,
        price,
        rating,
        sd,
        ssd,
        title);
  }
}
