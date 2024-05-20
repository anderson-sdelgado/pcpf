import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/usecases/database/add_all_visitante.dart';
import 'package:pcp/infra/model/web_service/stable/visitante_web_service_model.dart';

import '../../../utils/const.dart';

main() {

  group('Test AddAllVisitante', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final list = jsonDecode(DATA_VISITANTE);
      final listVisitanteWSModel = (list as List)
          .map((e) => VisitanteWebServiceModelInput.fromMap(e))
          .toList();
      final listVisitante =  listVisitanteWSModel.map((e) => Visitante.fromWebServiceModelToEntity(e)).toList();
      final addAllVisitante = await getIt.getAsync<AddAllVisitante>();
      final result = await addAllVisitante(listVisitante);
      expect(result.isRight(), true);
    });

  });

}
