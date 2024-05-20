import 'package:mockito/annotations.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';

@GenerateMocks([
  ConfigRepository,
  ColabRepository,
  EquipRepository,
  LocalRepository,
  TerceiroRepository,
  VisitanteRepository,
])
main() {}
