import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class ConfigRepository {
  Future<bool> hasConfig();
  Future<String> getSenhaConfig();
  Future<Either<Failure, num>> sendConfig(Config config);
}
