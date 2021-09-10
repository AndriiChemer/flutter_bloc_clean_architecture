import 'dart:convert';

import 'package:flutter_cars_app/core/errors/exceptions.dart';
import 'package:flutter_cars_app/data/models/car/car_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CarLocalDataSource {
  Future<List<CarModel>> getCarList();
  Future<void> cacheCarList(List<CarModel> cars);
}

const CACHED_CAR_LIST = 'CACHED_CAR_LIST';

class CarLocalDataSourceImpl implements CarLocalDataSource {
  final SharedPreferences sharedPreferences;

  CarLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCarList(List<CarModel> cars) {
    var object = cars.map((car) => car.toJsonMap()).toList();

    return sharedPreferences.setString(
      CACHED_CAR_LIST,
      jsonEncode(object),
    );
  }

  @override
  Future<List<CarModel>> getCarList() {
    final jsonString = sharedPreferences.getString(CACHED_CAR_LIST);

    if (jsonString != null) {
      try {
        var jsonObject = json.decode(jsonString) as List<dynamic>;
        var carList = jsonObject.map((map) => CarModel.fromMapJson(map)).toList();
        return Future.value(carList);
      } catch(error) {
        throw CacheException();
      }
    } else {
      return Future.value([]);
    }
  }
}