
import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/data/datasource/data_sources.dart';
import 'package:flutter_cars_app/data/models/models.dart';
import 'package:flutter_cars_app/data/repositories/repositoies.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'car_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, CarLocalDataSource, CarRemoteDataSource])
void main() {
  final mockNetworkInfo = MockNetworkInfo();
  final mockCarLocalDataSource = MockCarLocalDataSource();
  final mockCarRemoteDataSource = MockCarRemoteDataSource();
  late CarRepositoryImpl carRepositoryImpl;

  setUp(() {
    carRepositoryImpl = CarRepositoryImpl(
      networkInfo: mockNetworkInfo,
      localCarDataSource: mockCarLocalDataSource,
      remoteCarDataSource: mockCarRemoteDataSource,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getCarList', () {
    test(
      'should check if the device is online',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockCarRemoteDataSource.getCarList()).thenAnswer((_) async => carModelList);

        carRepositoryImpl.getCarList();

        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
            () async {

          when(mockCarRemoteDataSource.getCarList())
              .thenAnswer((_) async => carModelList);

          final result = await carRepositoryImpl.getCarList();

          verify(mockCarRemoteDataSource.getCarList());

          expect(result, equals(Right<Failure, List<Car>>(carList)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
            () async {
          when(mockCarRemoteDataSource.getCarList())
              .thenAnswer((_) async => carModelList);

          await carRepositoryImpl.getCarList();

          verify(mockCarRemoteDataSource.getCarList());
          verify(mockCarLocalDataSource.cacheCarList(carModelList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          when(mockCarRemoteDataSource.getCarList())
              .thenThrow(ServerException());

          final result = await carRepositoryImpl.getCarList();

          verify(mockCarRemoteDataSource.getCarList());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
            () async {

          when(mockCarLocalDataSource.getCarList())
              .thenAnswer((_) async => carModelList);

          final result = await carRepositoryImpl.getCarList();

          verify(mockCarLocalDataSource.getCarList());
          expect(result, equals(Right(carList)));
        },
      );

      test(
        'should return CacheFailure  when the call to local data source is failure',
            () async {
          when(mockCarLocalDataSource.getCarList())
              .thenThrow(CacheException());

          final result = await carRepositoryImpl.getCarList();

          verify(mockCarLocalDataSource.getCarList());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

}

final carModelList = [carModel];
final carList = [car];
final carModel = CarModel(
    id: "id",
    registration: 'registration',
    ownerId: 'ownerId',
    lng: 0.0,
    lat: 0.0,
    year: 'year',
    color: 'color',
    model: 'model',
    brand: 'brand'
);

final car = Car(
    registration: 'registration',
    ownerId: 'ownerId',
    lng: 0.0,
    lat: 0.0,
    year: 'year',
    color: 'color',
    model: 'model',
    brand: 'brand',
    id: 'id'
);