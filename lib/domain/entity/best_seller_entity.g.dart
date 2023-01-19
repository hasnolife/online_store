// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_seller_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellerEntity _$BestSellerEntityFromJson(Map<String, dynamic> json) =>
    BestSellerEntity(
      id: json['id'] as int,
      isFavorites: json['is_favorites'] as bool,
      title: json['title'] as String,
      priceWithoutDiscount: json['price_without_discount'] as int,
      discountPrice: json['discount_price'] as int,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$BestSellerEntityToJson(BestSellerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_favorites': instance.isFavorites,
      'title': instance.title,
      'price_without_discount': instance.priceWithoutDiscount,
      'discount_price': instance.discountPrice,
      'picture': instance.picture,
    };
