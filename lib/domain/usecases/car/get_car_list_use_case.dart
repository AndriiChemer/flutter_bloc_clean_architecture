import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/errors/failure.dart';
import 'package:flutter_cars_app/core/usecase/usecase.dart';
import 'package:flutter_cars_app/domain/entities/car/car.dart';

import '../../domain.dart';


class GetCarListUseCase implements EmptyUseCase<List<Car>> {

  final CarRepository repository;

  GetCarListUseCase(this.repository);

  @override
  Future<Either<Failure, List<Car>>> call() async {
    return await repository.getCarList();
  }
}