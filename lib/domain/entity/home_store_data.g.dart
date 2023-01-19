// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStoreData _$HomeStoreDataFromJson(Map<String, dynamic> json) =>
    HomeStoreData(
      hotSales: (json['home_store'] as List<dynamic>)
          .map((e) => HotSalesEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestSeller: (json['best_seller'] as List<dynamic>)
          .map((e) => BestSellerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeStoreDataToJson(HomeStoreData instance) =>
    <String, dynamic>{
      'home_store': instance.hotSales.map((e) => e.toJson()).toList(),
      'best_seller': instance.bestSeller.map((e) => e.toJson()).toList(),
    };
