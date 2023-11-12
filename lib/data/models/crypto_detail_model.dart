import 'package:json_annotation/json_annotation.dart';

part 'crypto_detail_model.g.dart';

@JsonSerializable()
class CryptoDetailModel {
  final int id;
  final String logo;

  CryptoDetailModel({
    required this.id,
    required this.logo,
  });

  factory CryptoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoDetailModelToJson(this);
}
