import 'package:json_annotation/json_annotation.dart';

part 'hot_sales_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HotSalesEntity {
  final int id;
  final bool? isNew;
  final String title;
  final String subtitle;
  final String picture;
  final bool isBuy;

  HotSalesEntity({
    required this.id,
    required this.isNew,
    required this.title,
    required this.subtitle,
    required this.picture,
    required this.isBuy,
  });

  factory HotSalesEntity.fromJson(Map<String, dynamic> json) =>
      _$HotSalesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HotSalesEntityToJson(this);
}
