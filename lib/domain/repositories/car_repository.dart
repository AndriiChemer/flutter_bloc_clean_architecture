import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/errors/failure.dart';
import 'package:flutter_cars_app/domain/entities/car/car.dart';

abstract class CarRepository {
  Future<Either<Failure, List<Car>>> getCarList();
}