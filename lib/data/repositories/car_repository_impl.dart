import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/converters/converters.dart';
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
  final Converter<List<CarModel>, List<Car>> converter;

  CarRepositoryImpl({
    required this.converter,
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

        return Right(converter.convert(remoteCarList));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCarList = await localCarDataSource.getCarList();
        return Right(converter.convert(localCarList));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}