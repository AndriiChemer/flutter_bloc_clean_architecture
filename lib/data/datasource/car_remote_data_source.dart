import 'dart:convert';

import 'package:flutter_cars_app/core/errors/exceptions.dart';
import 'package:flutter_cars_app/data/models/car/car_model.dart';
import 'package:http/http.dart' as http;

abstract class CarRemoteDataSource {
  Future<List<CarModel>> getCarList();
}
const String BASE_URL = "https://iteorecruitment-591c.restdb.io/rest";

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final http.Client client;
  final headers = {"x-apikey": "795ad45e4dc222bc0e5bd1c163bb885e3635e"};

  CarRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CarModel>> getCarList() async {
    final url = Uri.parse("$BASE_URL/car-list");
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((e) => CarModel.fromMapJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}