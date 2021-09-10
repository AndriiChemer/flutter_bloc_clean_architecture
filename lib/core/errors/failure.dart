import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure([String message = "server_error_occurred"]) : super(message);

}

class CacheFailure extends Failure {
  CacheFailure([String message = "cache_error_occurred"]) : super(message);
}