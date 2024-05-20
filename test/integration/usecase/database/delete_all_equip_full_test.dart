import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/database/delete_all_equip.dart';

main() {

  group('Test DeleteAllEquip', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final deleteAllEquip = await getIt.getAsync<DeleteAllEquip>();
      final result = await deleteAllEquip();
      expect(result.isRight(), true);
    });

  });

}