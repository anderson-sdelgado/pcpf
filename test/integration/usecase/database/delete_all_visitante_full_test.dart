import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/database/delete_all_visitante.dart';

main() {

  group('Test DeleteAllVisitante', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final deleteAllVisitante = await getIt.getAsync<DeleteAllVisitante>();
      final result = await deleteAllVisitante();
      expect(result.isRight(), true);
    });

  });

}