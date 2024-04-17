import 'package:equatable/equatable.dart';

abstract class SenhaStates extends Equatable {}

class InitialSenhaStates extends SenhaStates {
  @override
  List<Object?> get props => [];
}

class SuccessSenhaStates extends SenhaStates {
  @override
  List<Object?> get props => [];
}

class FailSenhaStates extends SenhaStates {
  @override
  List<Object?> get props => [];
}
