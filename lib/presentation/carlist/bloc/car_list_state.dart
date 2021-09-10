part of 'car_list_bloc.dart';

abstract class CarListState extends Equatable {
  const CarListState();
}

class CarListInitial extends CarListState {
  @override
  List<Object> get props => [];
}

class CarListLoading extends CarListState {
  @override
  List<Object> get props => [];
}

class CarListLoaded extends CarListState {

  final List<Car> carList;

  CarListLoaded(this.carList);

  @override
  List<Object> get props => [carList];
}

class CarListError extends CarListState {

  final String message;

  CarListError([this.message = "something_went_wrong"]);
  @override
  List<Object> get props => [];
}
