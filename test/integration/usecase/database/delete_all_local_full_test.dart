import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/database/delete_all_local.dart';

main() {

  group('Test DeleteAllLocal', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final deleteAllLocal = await getIt.getAsync<DeleteAllLocal>();
      final result = await deleteAllLocal();
      expect(result.isRight(), true);
    });

  });

}