import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/usecases/database/add_all_colab.dart';
import 'package:pcp/infra/model/web_service/stable/colab_web_service_model.dart';

import '../../../utils/const.dart';

main() {

  group('Test AddAllColab', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final list = jsonDecode(DATA_COLAB);
      final listColabWSModel = (list as List)
          .map((e) => ColabWebServiceModelInput.fromMap(e))
          .toList();
      final listColab =  listColabWSModel.map((e) => Colab.fromWebServiceModelToEntity(e)).toList();
      final addAllColab = await getIt.getAsync<AddAllColab>();
      final result = await addAllColab(listColab);
      expect(result.isRight(), true);
    });

  });

}

