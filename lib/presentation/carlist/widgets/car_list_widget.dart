import 'package:flutter/material.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';

import 'car_item_widget.dart';

class CarListWidget extends StatelessWidget {
  final List<Car> cars;
  const CarListWidget({Key? key, this.cars = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: cars.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index) =>  CarItemWidget(car: cars[index],)
    );
  }
}
