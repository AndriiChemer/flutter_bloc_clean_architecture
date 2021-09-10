import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cars_app/main.dart';
import 'package:flutter_cars_app/presentation/carlist/bloc/car_list_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../dependency_injection.dart';
import '../widgets/widgets.dart';

class CarListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("car_list")),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: () {
            context.setLocale(supportedLocalization[0]);
          }, child: Icon(Icons.home))
        ],

        leading: ElevatedButton(onPressed: () {
          context.setLocale(supportedLocalization[1]);
        }, child: Icon(Icons.home_outlined)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Container(
            child: BlocBuilder<CarListBloc, CarListState>(
              builder: (context, state) {

                if(state is CarListLoading) {
                  return LoadingWidget();
                } else if(state is CarListLoaded) {
                  return CarListWidget(cars: state.carList,);
                } else if(state is CarListError) {
                  return ErrorMessageWidget(message: state.message,);
                }

                return Container();
              }
            )
          ),
        ),
      ),
    );
  }


  Future<void> _onRefresh() async {
    getIt.get<CarListBloc>().add(GetCarList());
  }
}