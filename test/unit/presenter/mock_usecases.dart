import 'package:mockito/annotations.dart';
import 'package:pcp/domain/usecases/database/add_all_colab.dart';
import 'package:pcp/domain/usecases/database/add_all_equip.dart';
import 'package:pcp/domain/usecases/database/add_all_local.dart';
import 'package:pcp/domain/usecases/database/add_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/add_all_visitante.dart';
import 'package:pcp/domain/usecases/database/delete_all_colab.dart';
import 'package:pcp/domain/usecases/database/delete_all_equip.dart';
import 'package:pcp/domain/usecases/database/delete_all_local.dart';
import 'package:pcp/domain/usecases/database/delete_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/delete_all_visitante.dart';
import 'package:pcp/domain/usecases/database/recover_all_colab.dart';
import 'package:pcp/domain/usecases/database/recover_all_equip.dart';
import 'package:pcp/domain/usecases/database/recover_all_local.dart';
import 'package:pcp/domain/usecases/database/recover_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/recover_all_visitante.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/domain/usecases/initial/check_status_update_database.dart';
import 'package:pcp/domain/usecases/initial/save_initial_config.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';
import 'package:pcp/domain/usecases/initial/set_config_all_database_update.dart';

@GenerateMocks([
  SendInitialConfig,
  SaveInitialConfig,
  DeleteAllColab,
  RecoverAllColab,
  AddAllColab,
  DeleteAllEquip,
  RecoverAllEquip,
  AddAllEquip,
  DeleteAllLocal,
  RecoverAllLocal,
  AddAllLocal,
  DeleteAllTerceiro,
  RecoverAllTerceiro,
  AddAllTerceiro,
  DeleteAllVisitante,
  RecoverAllVisitante,
  AddAllVisitante,
  SetConfigAllDatabaseUpdate,
  CheckPasswordConfig,
  CheckStatusUpdateDatabase,
])
main() {}