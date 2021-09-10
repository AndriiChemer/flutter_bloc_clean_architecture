part of 'car_list_bloc.dart';

abstract class CarListEvent extends Equatable {
  const CarListEvent();
}

class GetCarList extends CarListEvent {

  @override
  List<Object?> get props => [];
}
