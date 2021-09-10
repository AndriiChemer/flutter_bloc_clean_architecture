import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/core/errors/failure.dart';
import 'package:flutter_cars_app/data/datasource/data_sources.dart';
import 'package:flutter_cars_app/data/models/models.dart';
import 'package:flutter_cars_app/domain/domain.dart';
import 'package:flutter_cars_app/domain/entities/car/car.dart';

class CarRepositoryImpl implements CarRepository {
  final NetworkInfo networkInfo;
  final CarLocalDataSource localCarDataSource;
  final CarRemoteDataSource remoteCarDataSource;

  CarRepositoryImpl({
    required this.localCarDataSource,
    required this.remoteCarDataSource,
    required this.networkInfo,
  });

  
  @override
  Future<Either<Failure, List<Car>>> getCarList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCarList = await remoteCarDataSource.getCarList();
        localCarDataSource.cacheCarList(remoteCarList);

        return Right(_convertCarList(remoteCarList));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCarList = await localCarDataSource.getCarList();
        return Right(_convertCarList(localCarList));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  //TODO make converter and inject in constructor
  List<Car> _convertCarList(List<CarModel> listCarModel) {
    return listCarModel.map((carModel) => Car(
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