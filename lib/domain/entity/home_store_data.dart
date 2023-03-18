import 'package:json_annotation/json_annotation.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/hot_sales_entity.dart';
part 'home_store_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HomeStoreData {
  @JsonKey(name: "home_store")
  List<HotSalesEntity> hotSales;
  List<BestSellerEntity> bestSeller;

  factory HomeStoreData.fromJson(Map<String, dynamic> json) => _$HomeStoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoreDataToJson(this);

//<editor-fold desc="Data Methods">
  HomeStoreData({
    required this.hotSales,
    required this.bestSeller,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeStoreData &&
          runtimeType == other.runtimeType &&
          hotSales == other.hotSales &&
          bestSeller == other.bestSeller);

  @override
  int get hashCode => hotSales.hashCode ^ bestSeller.hashCode;

  HomeStoreData copyWith({
    List<HotSalesEntity>? hotSales,
    List<BestSellerEntity>? bestSeller,
  }) {
    return HomeStoreData(
      hotSales: hotSales ?? this.hotSales,
      bestSeller: bestSeller ?? this.bestSeller,
    );
  }

//</editor-fold>
}
