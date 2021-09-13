import 'package:flutter_cars_app/data/models/models.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';

import 'converter.dart';

class CarListConverter implements Converter<List<CarModel>, List<Car>> {
  @override
  List<Car> convert(List<CarModel> models) {
    return models.map((carModel) => Car(
        id: carModel.id,
        brand: carModel.brand,
        model: carModel.model,
        color: carModel.color,
        registration: carModel.registration,
        year: carModel.year,
        ownerId: carModel.ownerId,
        lat: carModel.lat,
        lng: carModel.lat
    )).toList();
  }
}