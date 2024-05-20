import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable with EquatableMixin implements Exception {}

class ErrorRepository implements Failure {
  final String? message;
  ErrorRepository(this.message);

  @override
  List<Object?> get props => [
    message
  ];

  @override
  bool? get stringify => true;
}

class ErrorFloorDatasource implements Failure {
  final String? message;
  ErrorFloorDatasource(this.message);

  @override
  List<Object?> get props => [
    message
  ];

  @override
  bool? get stringify => true;
}

class ErrorWebServiceDatasource implements Failure {
  final String? message;
  ErrorWebServiceDatasource(this.message);

  @override
  List<Object?> get props => [
    message
  ];

  @override
  bool? get stringify => true;

}