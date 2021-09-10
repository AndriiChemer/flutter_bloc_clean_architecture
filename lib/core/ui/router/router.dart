import 'package:auto_route/auto_route.dart';
import 'package:flutter_cars_app/presentation/carlist/page/car_list_page.dart';
import 'package:flutter_cars_app/presentation/settings/page/settings_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: CarListPage, initial: true),
    AutoRoute(page: SettingsPage),
  ]
)
class $AppRouter {}