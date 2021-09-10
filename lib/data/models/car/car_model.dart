import 'package:freezed_annotation/freezed_annotation.dart';
part 'car_model.freezed.dart';
part 'car_model.g.dart';

@freezed
@JsonSerializable(createToJson: true)
class CarModel with _$CarModel {
  const CarModel._();

  factory CarModel({
    @Default("") @JsonKey(name: "_id") String id,
    required String brand,
    required String model,
    required String color,
    required String registration,
    required String year,
    required String ownerId,
    required double lat,
    required double lng,
  }) = _CarModel;

  factory CarModel.fromMapJson(Map<String, dynamic> map) => _$CarModelFromJson(map);

  Map<String, dynamic> toJsonMap() => _$CarModelToJson(this);
}