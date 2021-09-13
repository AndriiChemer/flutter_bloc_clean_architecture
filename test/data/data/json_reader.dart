import 'dart:convert';
import 'dart:io';

import 'package:flutter_cars_app/data/models/models.dart';

String readJsonAsString(String name) => File('test/data/data/$name').readAsStringSync();


List<CarModel> getCarModelListFromJson(String jsonString) {
  var jsonObject = json.decode(jsonString) as List<dynamic>;
  var carList = jsonObject.map((map) => CarModel.fromMapJson(map)).toList();

  return carList;
}