// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      (json['basket'] as List<dynamic>)
          .map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['delivery'] as String,
      json['id'] as String,
      json['total'] as int,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'basket': instance.basket.map((e) => e.toJson()).toList(),
      'delivery': instance.delivery,
      'id': instance.id,
      'total': instance.total,
    };

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
      json['id'] as int,
      json['images'] as String,
      json['price'] as int,
      json['title'] as String,
    );

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
      'price': instance.price,
      'title': instance.title,
    };
