import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
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
import 'package:pcp/domain/usecases/initial/save_initial_config.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';
import 'package:pcp/domain/usecases/initial/set_config_all_database_update.dart';
import 'package:pcp/presenter/initial/config/cubit/config_states.dart';
import 'package:pcp/utils/constant.dart';

class ConfigCubit extends Cubit<ConfigStates> {
  final SendInitialConfig sendInitialConfig;
  final SaveInitialConfig saveInitialConfig;
  final DeleteAllColab deleteAllColab;
  final RecoverAllColab recoverAllColab;
  final AddAllColab addAllColab;
  final DeleteAllEquip deleteAllEquip;
  final RecoverAllEquip recoverAllEquip;
  final AddAllEquip addAllEquip;
  final DeleteAllLocal deleteAllLocal;
  final RecoverAllLocal recoverAllLocal;
  final AddAllLocal addAllLocal;
  final DeleteAllTerceiro deleteAllTerceiro;
  final RecoverAllTerceiro recoverAllTerceiro;
  final AddAllTerceiro addAllTerceiro;
  final DeleteAllVisitante deleteAllVisitante;
  final RecoverAllVisitante recoverAllVisitante;
  final AddAllVisitante addAllVisitante;
  final SetConfigAllDatabaseUpdate setConfigAllDatabaseUpdate;

  ConfigCubit(
    this.sendInitialConfig,
    this.saveInitialConfig,
    this.deleteAllColab,
    this.recoverAllColab,
    this.addAllColab,
    this.deleteAllEquip,
    this.recoverAllEquip,
    this.addAllEquip,
    this.deleteAllLocal,
    this.recoverAllLocal,
    this.addAllLocal,
    this.deleteAllTerceiro,
    this.recoverAllTerceiro,
    this.addAllTerceiro,
    this.deleteAllVisitante,
    this.recoverAllVisitante,
    this.addAllVisitante,
    this.setConfigAllDatabaseUpdate,
  ) : super(InitialConfigStates());

  Future<void> saveConfig({
    required String password,
    required String nroAparelho,
    required String version,
  }) async {
    emit(SendConfigStates());
    final result = await sendInitialConfig(
        senha: password, version: version, nroAparelho: nroAparelho);
    result.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) async {
      emit(SaveConfigStates());
      await saveInitialConfig(
        nroAparelho: nroAparelho,
        senha: password,
        version: version,
        idDB: r,
      );
      emit(FinishConfigStates());
    });
  }

  Future<void> updateAllDatabase() async {
    if (!await _updateAllColab(1)) return;
    if (!await _updateAllEquip(2)) return;
    if (!await _updateAllLocal(3)) return;
    if (!await _updateAllTerceiro(4)) return;
    if (!await _updateAllVisitante(5)) return;
    await setConfigAllDatabaseUpdate();
    emit(FinishUpdateTableStates());
  }

  Future<bool> _updateAllColab(int pos) async {
    emit(DeleteTableStates(TABLE_FLOOR_COLAB, pos));
    final deleteAll = await deleteAllColab();
    if (deleteAll.isLeft()) {
      deleteAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    emit(RecoverDataTableStates(TABLE_FLOOR_COLAB, pos));
    final recoverAll = await recoverAllColab();
    List<Colab> list = [];
    recoverAll.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) {
      list = r;
    });
    if (recoverAll.isLeft()) return false;
    emit(AddDataTableStates(TABLE_FLOOR_COLAB, pos));
    final addAll = await addAllColab(list);
    if (addAll.isLeft()) {
      addAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    return true;
  }

  Future<bool> _updateAllEquip(int pos) async {
    emit(DeleteTableStates(TABLE_FLOOR_EQUIP, pos));
    final deleteAll = await deleteAllEquip();
    if (deleteAll.isLeft()) {
      deleteAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    emit(RecoverDataTableStates(TABLE_FLOOR_EQUIP, pos));
    final recoverAll = await recoverAllEquip();
    List<Equip> list = [];
    recoverAll.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) {
      list = r;
    });
    if (recoverAll.isLeft()) return false;
    emit(AddDataTableStates(TABLE_FLOOR_EQUIP, pos));
    final addAll = await addAllEquip(list);
    if (addAll.isLeft()) {
      addAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    return true;
  }

  Future<bool> _updateAllLocal(int pos) async {
    emit(DeleteTableStates(TABLE_FLOOR_LOCAL, pos));
    final deleteAll = await deleteAllLocal();
    if (deleteAll.isLeft()) {
      deleteAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    emit(RecoverDataTableStates(TABLE_FLOOR_LOCAL, pos));
    final recoverAll = await recoverAllLocal();
    List<Local> list = [];
    recoverAll.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) {
      list = r;
    });
    if (recoverAll.isLeft()) return false;
    emit(AddDataTableStates(TABLE_FLOOR_LOCAL, pos));
    final addAll = await addAllLocal(list);
    if (addAll.isLeft()) {
      addAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    return true;
  }

  Future<bool> _updateAllTerceiro(int pos) async {
    emit(DeleteTableStates(TABLE_FLOOR_TERCEIRO, pos));
    final deleteAll = await deleteAllTerceiro();
    if (deleteAll.isLeft()) {
      deleteAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    emit(RecoverDataTableStates(TABLE_FLOOR_TERCEIRO, pos));
    final recoverAll = await recoverAllTerceiro();
    List<Terceiro> list = [];
    recoverAll.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) {
      list = r;
    });
    if (recoverAll.isLeft()) return false;
    emit(AddDataTableStates(TABLE_FLOOR_TERCEIRO, pos));
    final addAll = await addAllTerceiro(list);
    if (addAll.isLeft()) {
      addAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    return true;
  }

  Future<bool> _updateAllVisitante(int pos) async {
    emit(DeleteTableStates(TABLE_FLOOR_VISITANTE, pos));
    final deleteAll = await deleteAllVisitante();
    if (deleteAll.isLeft()) {
      deleteAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    emit(RecoverDataTableStates(TABLE_FLOOR_VISITANTE, pos));
    final recoverAll = await recoverAllVisitante();
    List<Visitante> list = [];
    recoverAll.fold((l) {
      emit(ErrorConfigStates(l));
    }, (r) {
      list = r;
    });
    if (recoverAll.isLeft()) return false;
    emit(AddDataTableStates(TABLE_FLOOR_VISITANTE, pos));
    final addAll = await addAllVisitante(list);
    if (addAll.isLeft()) {
      addAll.fold((l) {
        emit(ErrorConfigStates(l));
      }, (r) => null);
      return false;
    }
    return true;
  }
}
