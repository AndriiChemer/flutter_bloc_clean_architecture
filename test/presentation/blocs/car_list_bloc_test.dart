import 'package:dartz/dartz.dart';
import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/domain/domain.dart';
import 'package:flutter_cars_app/presentation/carlist/bloc/car_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'car_list_bloc_test.mocks.dart';

@GenerateMocks([GetCarListUseCase])
void main() {
  final mockGetCarListUseCase = MockGetCarListUseCase();
  CarListBloc? carListBloc;

  setUp(() {
    carListBloc = CarListBloc(getCarListUseCase: mockGetCarListUseCase);
  });

  group('Car list bloc', () {
    test('initial state should be CarListInitial', () {
      expect(carListBloc!.state, equals(carListInitialState));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () {
      expectLater(carListBloc!.stream, emitsInOrder([carListLoadingState, carListLoadedState]));

      when(mockGetCarListUseCase.call()).thenAnswer((_) async => Right([]));

      carListBloc!.add(GetCarList());
    });

    test('should emit [Loading, Error] when getting data fails', () {
      expectLater(carListBloc!.stream, emitsInOrder([carListLoadingState, carListErrorState]));

      when(mockGetCarListUseCase.call()).thenAnswer((_) async => Left(ServerFailure()));

      carListBloc!.add(GetCarList());
    });

  });
}

const carListInitialState = TypeMatcher<CarListInitial>();
const carListLoadingState = TypeMatcher<CarListLoading>();
const carListLoadedState = TypeMatcher<CarListLoaded>();
const carListErrorState = TypeMatcher<CarListError>();