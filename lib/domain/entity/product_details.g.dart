// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      json['CPU'] as String,
      json['camera'] as String,
      (json['capacity'] as List<dynamic>).map((e) => e as String).toList(),
      (json['color'] as List<dynamic>).map((e) => e as String).toList(),
      json['id'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      json['price'] as int,
      (json['rating'] as num).toDouble(),
      json['sd'] as String,
      json['ssd'] as String,
      json['title'] as String,
      isFavorites: json['isFavorites'] as bool,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'CPU': instance.cpu,
      'camera': instance.camera,
      'capacity': instance.capacity,
      'color': instance.color,
      'id': instance.id,
      'images': instance.images,
      'isFavorites': instance.isFavorites,
      'price': instance.price,
      'rating': instance.rating,
      'sd': instance.sd,
      'ssd': instance.ssd,
      'title': instance.title,
    };
