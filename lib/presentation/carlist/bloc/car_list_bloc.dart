import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cars_app/domain/domain.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';

part 'car_list_event.dart';
part 'car_list_state.dart';

class CarListBloc extends Bloc<CarListEvent, CarListState> {
  final GetCarListUseCase getCarListUseCase;

  CarListBloc({
    required this.getCarListUseCase
  }) : super(CarListInitial());

  @override
  Stream<CarListState> mapEventToState(
    CarListEvent event,
  ) async* {
    if(event is GetCarList) {
      yield* _mapGettingCarList();
    }
  }

  Stream<CarListState> _mapGettingCarList() async* {
    yield CarListLoading();
    final failureOrCarList = await getCarListUseCase.call();

    final newState = failureOrCarList.fold(
            (failure) => CarListError(failure.message),
            (carList) => CarListLoaded(carList));

    yield newState;
  }
}
