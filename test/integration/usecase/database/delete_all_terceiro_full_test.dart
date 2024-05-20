import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/database/delete_all_terceiro.dart';

main() {

  group('Test DeleteAllTerceiro', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final deleteAllTerceiro = await getIt.getAsync<DeleteAllTerceiro>();
      final result = await deleteAllTerceiro();
      expect(result.isRight(), true);
    });

  });

}