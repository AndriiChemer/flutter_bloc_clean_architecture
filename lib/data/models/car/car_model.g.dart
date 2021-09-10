// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) {
  return CarModel(
    id: json['_id'] as String,
    brand: json['brand'] as String,
    model: json['model'] as String,
    color: json['color'] as String,
    registration: json['registration'] as String,
    year: json['year'] as String,
    ownerId: json['ownerId'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      '_id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'color': instance.color,
      'registration': instance.registration,
      'year': instance.year,
      'ownerId': instance.ownerId,
      'lat': instance.lat,
      'lng': instance.lng,
    };
