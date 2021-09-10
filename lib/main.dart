import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cars_app/presentation/carlist/bloc/car_list_bloc.dart';
import 'package:flutter_cars_app/presentation/carlist/page/car_list_page.dart';
import 'dependency_injection.dart' as di;

const supportedLocalization = [
  Locale('en', 'US'),
  Locale('pl', 'PL')
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await di.initDependencyInjection();

  // runApp(MyApp());


  runApp(EasyLocalization(
    path: 'assets/locales',
    supportedLocales: supportedLocalization,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var carListBloc = di.getIt.get<CarListBloc>();
    carListBloc.add(GetCarList());

    return MaterialApp(
      title: 'Cars app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => carListBloc,
        child: CarListPage(),
      ),
    );
  }

}
