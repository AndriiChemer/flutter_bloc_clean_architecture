import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/domain/entities/entities.dart';

class CarItemWidget extends StatelessWidget {
  final Car car;
  const CarItemWidget({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${car.brand} ${car.model}"),
              Text("${car.year}"),
            ],
          ),

          SizedBox(height: 30,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${tr('registration_number')} ${car.registration}"),

              Row(
                children: [
                  Text(tr('color')),
                  Container(
                    width: 10,
                    height: 10,
                    color: hexToColor(car.color),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


}
