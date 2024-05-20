import 'dart:async';

import 'package:floor/floor.dart';
import 'package:pcp/external/floor/dao/colab_dao.dart';
import 'package:pcp/external/floor/dao/equip_dao.dart';
import 'package:pcp/external/floor/dao/local_dao.dart';
import 'package:pcp/external/floor/dao/terceiro_dao.dart';
import 'package:pcp/external/floor/dao/visitante_dao.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [
  ColabFloorModel,
  EquipFloorModel,
  LocalFloorModel,
  TerceiroFloorModel,
  VisitanteFloorModel,
])
abstract class AppDatabase extends FloorDatabase {
  ColabDao get colabDao;
  EquipDao get equipDao;
  LocalDao get localDao;
  TerceiroDao get terceiroDao;
  VisitanteDao get visitanteDao;
}
