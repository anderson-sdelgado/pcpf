import 'package:equatable/equatable.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class ConfigStates extends Equatable {}

class InitialConfigStates extends ConfigStates {
  @override
  List<Object?> get props => [];
}

class ErrorConfigStates extends ConfigStates {
  final Failure failure;

  ErrorConfigStates(this.failure);

  @override
  List<Object?> get props => [failure];
}

class SendConfigStates extends ConfigStates {
  @override
  List<Object?> get props => [];
}

class SaveConfigStates extends ConfigStates {
  @override
  List<Object?> get props => [];
}

class FinishConfigStates extends ConfigStates {
  @override
  List<Object?> get props => [];
}

class DeleteTableStates extends ConfigStates {
  final String table;
  final int pos;

  DeleteTableStates(this.table, this.pos);

  @override
  List<Object?> get props => [
        table,
        pos,
      ];
}

class RecoverDataTableStates extends ConfigStates {
  final String table;
  final int pos;

  RecoverDataTableStates(this.table, this.pos);

  @override
  List<Object?> get props => [
        table,
        pos,
      ];
}

class AddDataTableStates extends ConfigStates {
  final String table;
  final int pos;

  AddDataTableStates(this.table, this.pos);

  @override
  List<Object?> get props => [
        table,
        pos,
      ];
}

class FinishUpdateTableStates extends ConfigStates {
  @override
  List<Object?> get props => [];
}

