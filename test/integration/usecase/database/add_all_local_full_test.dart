import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/usecases/database/add_all_local.dart';
import 'package:pcp/infra/model/web_service/stable/local_web_service_model.dart';

import '../../../utils/const.dart';

main() {

  group('Test AddAllLocal', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final list = jsonDecode(DATA_LOCAL);
      final listLocalWSModel = (list as List)
          .map((e) => LocalWebServiceModelInput.fromMap(e))
          .toList();
      final listLocal =  listLocalWSModel.map((e) => Local.fromWebServiceModelToEntity(e)).toList();
      final addAllLocal = await getIt.getAsync<AddAllLocal>();
      final result = await addAllLocal(listLocal);
      expect(result.isRight(), true);
    });

  });

}
