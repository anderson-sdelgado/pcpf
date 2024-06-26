import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/utils/enum.dart';

abstract class ConfigRepository {
  Future<bool> has();
  Future<String> getSenha();
  Future<num> getNroAparelho();
  Future<String> getVersion();
  Future<Either<Failure, num>> send(Config config);
  Future<void> save(Config config);
  Future<Config> getConfig();
  Future<FlagUpdate> getFlagUpdate();
}
