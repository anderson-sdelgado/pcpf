import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/entities/variable/config.dart';

main(){

  group("Test Entity Config", () {
    test("Testar 2 instancia igual", () {
      final config1 = Config(
          nroAparelhoConfig: 169974178400,
          passwordConfig: "12345",
          version: "1.0");
      final config2 = Config(
          nroAparelhoConfig: 169974178400,
          passwordConfig: "12345",
          version: "1.0");
      expect(config1, equals(config2));
    });

    test("Testar 2 instancia diferente", () {
      final config1 = Config(
          nroAparelhoConfig: 169974178400,
          passwordConfig: "12345",
          version: "1.0");
      final config2 = Config(
          nroAparelhoConfig: 169974178400,
          passwordConfig: "12345");
      expect(config1, isNot(equals(config2)));
    });
  });

}