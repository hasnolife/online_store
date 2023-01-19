// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

productDetails _$productDetailsFromJson(Map<String, dynamic> json) =>
    productDetails(
      json['CPU'] as String,
      json['camera'] as String,
      (json['capacity'] as List<dynamic>).map((e) => e as String).toList(),
      (json['color'] as List<dynamic>).map((e) => e as String).toList(),
      json['id'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      json['isFavorites'] as bool,
      json['price'] as int,
      (json['rating'] as num).toDouble(),
      json['sd'] as String,
      json['ssd'] as String,
      json['title'] as String,
    );

Map<String, dynamic> _$productDetailsToJson(productDetails instance) =>
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
