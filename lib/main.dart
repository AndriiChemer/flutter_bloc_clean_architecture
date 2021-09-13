import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars_app/presentation/carlist/bloc/car_list_bloc.dart';
import 'core/ui/router/router.gr.dart';
import 'dependency_injection.dart' as di;

const supportedLocalization = [
  Locale('en', 'US'),
  Locale('pl', 'PL')
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await di.initDependencyInjection();

  runApp(EasyLocalization(
    path: 'assets/locales',
    supportedLocales: supportedLocalization,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  final _carAppRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(_carAppRouter),
      routeInformationParser: _carAppRouter.defaultRouteParser(),
      title: 'Cars app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

}
