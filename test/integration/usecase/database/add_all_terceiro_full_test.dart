import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/usecases/database/add_all_terceiro.dart';
import 'package:pcp/infra/model/web_service/stable/terceiro_web_service_model.dart';

import '../../../utils/const.dart';

main() {

  group('Test AddAllTerceiro', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final list = jsonDecode(DATA_TERCEIRO);
      final listTerceiroWSModel = (list as List)
          .map((e) => TerceiroWebServiceModelInput.fromMap(e))
          .toList();
      final listTerceiro =  listTerceiroWSModel.map((e) => Terceiro.fromWebServiceModelToEntity(e)).toList();
      final addAllTerceiro = await getIt.getAsync<AddAllTerceiro>();
      final result = await addAllTerceiro(listTerceiro);
      expect(result.isRight(), true);
    });

  });

}
