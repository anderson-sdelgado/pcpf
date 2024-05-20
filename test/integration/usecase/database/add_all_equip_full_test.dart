import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/usecases/database/add_all_equip.dart';
import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';

import '../../../utils/const.dart';

main() {

  group('Test AddAllEquip', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final list = jsonDecode(DATA_EQUIP);
      final listEquipWSModel = (list as List)
          .map((e) => EquipWebServiceModelInput.fromMap(e))
          .toList();
      final listEquip =  listEquipWSModel.map((e) => Equip.fromWebServiceModelToEntity(e)).toList();
      final addAllEquip = await getIt.getAsync<AddAllEquip>();
      final result = await addAllEquip(listEquip);
      expect(result.isRight(), true);
    });

  });

}
