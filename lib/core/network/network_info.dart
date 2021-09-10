// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => _checkConnectivity();

  Future<bool> _checkConnectivity() async {
    ConnectivityResult connectivityResult = await connectionChecker.checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi
        || connectivityResult == ConnectivityResult.mobile;
  }
}