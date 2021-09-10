import 'package:freezed_annotation/freezed_annotation.dart';
part 'car.freezed.dart';

@freezed
class Car with _$Car {
  const Car._();

  factory Car({
    required String id,
    required String brand,
    required String model,
    required String color,
    required String registration,
    required String year,
    required String ownerId,
    required double lat,
    required double lng,
  }) = _Car;
}