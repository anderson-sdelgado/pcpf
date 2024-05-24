import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/config/cubit/config_states.dart';

import '../../../mock_usecases.mocks.dart';

final sendInitialConfig = MockSendInitialConfig();
final saveInitialConfig = MockSaveInitialConfig();
final deleteAllColab = MockDeleteAllColab();
final recoverAllColab = MockRecoverAllColab();
final addAllColab = MockAddAllColab();
final deleteAllEquip = MockDeleteAllEquip();
final recoverAllEquip = MockRecoverAllEquip();
final addAllEquip = MockAddAllEquip();
final deleteAllLocal = MockDeleteAllLocal();
final recoverAllLocal = MockRecoverAllLocal();
final addAllLocal = MockAddAllLocal();
final deleteAllTerceiro = MockDeleteAllTerceiro();
final recoverAllTerceiro = MockRecoverAllTerceiro();
final addAllTerceiro = MockAddAllTerceiro();
final deleteAllVisitante = MockDeleteAllVisitante();
final recoverAllVisitante = MockRecoverAllVisitante();
final addAllVisitante = MockAddAllVisitante();
final setConfigAllDatabaseUpdate = MockSetConfigAllDatabaseUpdate();

final listColab = [
  Colab(
    matricColab: 19759,
    nomeColab: "Anderson",
  ),
];

final listEquip = [
  Equip(
    idEquip: 1,
    nroEquip: 100,
  ),
];

final listLocal = [
  Local(
    idLocal: 1,
    descrLocal: "Usina",
  ),
];

final listTerceiro = [
  Terceiro(
    idTerceiro: 1,
    idBDTerceiro: 1,
    cpfTerceiro: "123.456.789-00",
    nomeTerceiro: "Teste",
    empresaTerceiro: "Empresa Teste",
  ),
];

final listVisitante = [
  Visitante(
    idVisitante: 1,
    cpfVisitante: "123.456.789-00",
    nomeVisitante: "Teste",
    empresaVisitante: "Empresa Teste",
  ),
];


main() {
  final configCubit = ConfigCubit(
    sendInitialConfig,
    saveInitialConfig,
    deleteAllColab,
    recoverAllColab,
    addAllColab,
    deleteAllEquip,
    recoverAllEquip,
    addAllEquip,
    deleteAllLocal,
    recoverAllLocal,
    addAllLocal,
    deleteAllTerceiro,
    recoverAllTerceiro,
    addAllTerceiro,
    deleteAllVisitante,
    recoverAllVisitante,
    addAllVisitante,
    setConfigAllDatabaseUpdate,
  );

  group("Test ConfigCubit", () {
    test('Verificar Estado initial', () async {
      expect(configCubit.state, InitialConfigStates());
    });

    blocTest<ConfigCubit, ConfigStates>(
      "Checar error de envio de Dados",
      build: () => configCubit,
      act: (cubit) {
        when(sendInitialConfig(
          nroAparelho: "16997417840",
          version: "1.0",
          senha: "12345",
        )).thenAnswer(
            (_) async => Left(ErrorWebServiceDatasource("Erro Conexão")));
        cubit.saveConfig(
          nroAparelho: "16997417840",
          version: "1.0",
          password: "12345",
        );
      },
      expect: () => [
        isA<SendConfigStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Checar Recebimento de envio de Dados",
      build: () => configCubit,
      act: (cubit) {
        when(sendInitialConfig(
          nroAparelho: "16997417840",
          version: "1.0",
          senha: "12345",
        )).thenAnswer((_) async => const Right(1));
        when(saveInitialConfig(
          nroAparelho: "16997417840",
          version: "1.0",
          senha: "12345",
          idDB: 1,
        )).thenAnswer((_) async => {});
        cubit.saveConfig(
          nroAparelho: "16997417840",
          version: "1.0",
          password: "12345",
        );
      },
      expect: () => [
        isA<SendConfigStates>(),
        isA<SaveConfigStates>(),
        isA<FinishConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Colab -> Checar Erro de exclusão de todos os dados da tabela",
      build: () => configCubit,
      act: (cubit) {
        when(deleteAllColab())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        isA<DeleteTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Colab -> Exclusão dos dados da tabela e falha no retorno das informações",
      build: () => configCubit,
      act: (cubit) {
        when(deleteAllColab()).thenAnswer((_) async => const Right(true));
        when(recoverAllColab())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Colab -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        when(deleteAllColab()).thenAnswer((_) async => const Right(true));
        when(recoverAllColab()).thenAnswer((_) async => Right(listColab));
        when(addAllColab(listColab))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Equip -> Checar Erro de exclusão de todos os dados da tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        when(deleteAllEquip())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Equip -> Exclusão dos dados da tabela e falha no retorno das informações",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        when(deleteAllEquip()).thenAnswer((_) async => const Right(true));
        when(recoverAllEquip())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Equip -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        when(deleteAllEquip()).thenAnswer((_) async => const Right(true));
        when(recoverAllEquip()).thenAnswer((_) async => Right(listEquip));
        when(addAllEquip(listEquip))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Local -> Checar Erro de exclusão de todos os dados da tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        when(deleteAllLocal())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Local -> Exclusão dos dados da tabela e falha no retorno das informações",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        when(deleteAllLocal()).thenAnswer((_) async => const Right(true));
        when(recoverAllLocal())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Local -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        when(deleteAllLocal()).thenAnswer((_) async => const Right(true));
        when(recoverAllLocal()).thenAnswer((_) async => Right(listLocal));
        when(addAllLocal(listLocal))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Terceiro -> Checar Erro de exclusão de todos os dados da tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        when(deleteAllTerceiro())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Terceiro -> Exclusão dos dados da tabela e falha no retorno das informações",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        when(deleteAllTerceiro()).thenAnswer((_) async => const Right(true));
        when(recoverAllTerceiro())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Terceiro -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        when(deleteAllTerceiro()).thenAnswer((_) async => const Right(true));
        when(recoverAllTerceiro()).thenAnswer((_) async => Right(listTerceiro));
        when(addAllTerceiro(listTerceiro))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Visitante -> Checar Erro de exclusão de todos os dados da tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        whenTerceiro();
        when(deleteAllVisitante())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Visitante -> Exclusão dos dados da tabela e falha no retorno das informações",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        whenTerceiro();
        when(deleteAllVisitante()).thenAnswer((_) async => const Right(true));
        when(recoverAllVisitante())
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Visitante -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        whenTerceiro();
        when(deleteAllVisitante()).thenAnswer((_) async => const Right(true));
        when(recoverAllVisitante())
            .thenAnswer((_) async => Right(listVisitante));
        when(addAllVisitante(listVisitante))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Visitante -> Exclusão dos dados da tabela, retorno das informações e falha inserção de dados na Tabela",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        whenTerceiro();
        when(deleteAllVisitante()).thenAnswer((_) async => const Right(true));
        when(recoverAllVisitante())
            .thenAnswer((_) async => Right(listVisitante));
        when(addAllVisitante(listVisitante))
            .thenAnswer((_) async => Left(ErrorRepository("")));
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<DeleteTableStates>(),
        isA<RecoverDataTableStates>(),
        isA<AddDataTableStates>(),
        isA<ErrorConfigStates>(),
      ],
    );

    blocTest<ConfigCubit, ConfigStates>(
      "Finalização de Atualização de Todas as Tabelas",
      build: () => configCubit,
      act: (cubit) {
        whenColab();
        whenEquip();
        whenLocal();
        whenTerceiro();
        whenVisitante();
        cubit.updateAllDatabase();
      },
      expect: () => [
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        ...statesTable(),
        isA<FinishUpdateTableStates>(),
      ],
    );
  });
}

whenColab() {
  when(deleteAllColab()).thenAnswer((_) async => const Right(true));
  when(recoverAllColab()).thenAnswer((_) async => Right(listColab));
  when(addAllColab(listColab)).thenAnswer((_) async => const Right(true));
}

whenEquip() {
  when(deleteAllEquip()).thenAnswer((_) async => const Right(true));
  when(recoverAllEquip()).thenAnswer((_) async => Right(listEquip));
  when(addAllEquip(listEquip)).thenAnswer((_) async => const Right(true));
}

whenLocal() {
  when(deleteAllLocal()).thenAnswer((_) async => const Right(true));
  when(recoverAllLocal()).thenAnswer((_) async => Right(listLocal));
  when(addAllLocal(listLocal)).thenAnswer((_) async => const Right(true));
}

whenTerceiro() {
  when(deleteAllTerceiro()).thenAnswer((_) async => const Right(true));
  when(recoverAllTerceiro()).thenAnswer((_) async => Right(listTerceiro));
  when(addAllTerceiro(listTerceiro)).thenAnswer((_) async => const Right(true));
}

whenVisitante() {
  when(deleteAllVisitante()).thenAnswer((_) async => const Right(true));
  when(recoverAllVisitante()).thenAnswer((_) async => Right(listVisitante));
  when(addAllVisitante(listVisitante))
      .thenAnswer((_) async => const Right(true));
}

List statesTable() {
  return [
    isA<DeleteTableStates>(),
    isA<RecoverDataTableStates>(),
    isA<AddDataTableStates>(),
  ];
}
