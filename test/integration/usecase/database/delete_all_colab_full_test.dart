import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/database/delete_all_colab.dart';

main() {

  group('Test DeleteAllColab', () {

    test('deve retornar true se apagar os dados', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup(test: true);
      final deleteAllColab = await getIt.getAsync<DeleteAllColab>();
      final result = await deleteAllColab();
      expect(result.isRight(), true);
    });

  });

}