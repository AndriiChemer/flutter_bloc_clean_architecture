import 'package:connectivity/connectivity.dart';
import 'package:flutter_cars_app/core/converters/converters.dart';
import 'package:flutter_cars_app/data/datasource/data_sources.dart';
import 'package:flutter_cars_app/data/models/car/car_model.dart';
import 'package:flutter_cars_app/data/repositories/car_repository_impl.dart';
import 'package:flutter_cars_app/domain/domain.dart';
import 'package:flutter_cars_app/domain/entities/car/car.dart';
import 'package:flutter_cars_app/presentation/carlist/bloc/car_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';

final getIt = GetIt.instance;

Future<void> initDependencyInjection() async {

  await _initCore();
  _initConverters();
  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initBlocs();

}

void _initConverters() {
  getIt.registerLazySingleton<Converter<List<CarModel>, List<Car>>>(() => CarListConverter());
}

void _initBlocs() {
  getIt.registerLazySingleton(() => CarListBloc(getCarListUseCase: getIt()),);
}
void _initUseCases() {
  getIt.registerLazySingleton(() => GetCarListUseCase(getIt()));
}

void _initRepositories() {
  getIt.registerLazySingleton<CarRepository>(
        () => CarRepositoryImpl(
          localCarDataSource: getIt(),
          remoteCarDataSource: getIt(),
          networkInfo: getIt(),
          converter: getIt()
        ),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<CarRemoteDataSource>(
        () => CarRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<CarLocalDataSource>(
        () => CarLocalDataSourceImpl(sharedPreferences: getIt()),
  );
}

Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
}