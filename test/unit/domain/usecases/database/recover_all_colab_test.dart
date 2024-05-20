import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/recover_all_colab.dart';
import 'package:pcp/utils/token.dart';
import '../../repository/mock_repositories.mocks.dart';

main() {
  final colabRepository = MockColabRepository();
  final configRepository = MockConfigRepository();

  group('Test RecoverAllColab', () {
    test("Retorno sucesso para recuperar os dados", () async {
      final list = [
        Colab(
          matricColab: 19759,
          nomeColab: "Anderson",
        ),
      ];
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      when(colabRepository.recoverAllColab(token("16997417840", "1.00")))
          .thenAnswer((_) => Future(() => Right(list)));
      final usecase = RecoverAllColabImpl(colabRepository, configRepository);
      final result = await usecase();
      expect(result.isRight(), true);
      expect(result.fold(id, id), list);
    });

    test("Retorno erro no repository na recuperacao os dados", () async {
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      when(colabRepository.recoverAllColab(token("16997417840", "1.00")))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Error"))));
      final usecase = RecoverAllColabImpl(colabRepository, configRepository);
      final result = await usecase();
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test("Retorno erro no Datasource Web Service na recuperacao os dados",
        () async {
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      when(colabRepository.recoverAllColab(token("16997417840", "1.00")))
          .thenAnswer(
              (_) => Future(() => Left(ErrorWebServiceDatasource("Error"))));
      final usecase = RecoverAllColabImpl(colabRepository, configRepository);
      final result = await usecase();
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });
  });
}
