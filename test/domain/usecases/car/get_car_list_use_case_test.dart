
import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/domain/domain.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_car_list_use_case_test.mocks.dart';

@GenerateMocks([CarRepository])
void main() {
  final mockCarRepository = MockCarRepository();
  late GetCarListUseCase getCarListUseCase;

  setUp(() {
    getCarListUseCase = GetCarListUseCase(mockCarRepository);
  });

  test(
    'should get car list from the repository',
        () async {

      List<Car> carList = [];

      when(mockCarRepository.getCarList())
          .thenAnswer((_) async => Right(carList));

      final result = await getCarListUseCase();

      expect(result, Right(carList));
      verify(mockCarRepository.getCarList());
      verifyNoMoreInteractions(mockCarRepository);
    },
  );
}