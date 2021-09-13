
import 'dart:convert';

import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/data/datasource/data_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/json_reader.dart';
import '../../repositories/car_repository_impl_test.dart';
import 'car_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late CarLocalDataSourceImpl dataSource;
  final mockSharedPreferences = MockSharedPreferences();

  setUp(() {
    dataSource = CarLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getCarList', () {

    test(
      'should return Car list from SharedPreferences',
          () async {

        final carList = getCarModelListFromJson(readJsonAsString('car_list.json'));

        when(mockSharedPreferences.getString(any))
            .thenReturn(readJsonAsString('car_list.json'));

        final result = await dataSource.getCarList();

        verify(mockSharedPreferences.getString(CACHED_CAR_LIST));
        expect(result, equals(carList));
      },
    );

    test(
      'should throw a CacheException when error occurred',
          () async {

        when(mockSharedPreferences.getString(any)).thenThrow(CacheException());

        final call = dataSource.getCarList;

        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheCarList', () {

    test(
      'should call SharedPreferences to cache the data',
          () async {

        final expectedJsonString = jsonEncode(
            carModelList.map((car) => car.toJsonMap()).toList()
        );

        when(mockSharedPreferences.setString(CACHED_CAR_LIST, expectedJsonString))
            .thenAnswer((_) async => true);

        dataSource.cacheCarList(carModelList);

        verify(mockSharedPreferences.setString(
          CACHED_CAR_LIST,
          expectedJsonString,
        ));
      },
    );
  });
}