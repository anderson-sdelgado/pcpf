import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';

import '../../../mock_usecases.mocks.dart';

void main() {
  final checkPasswordConfig = MockCheckPasswordConfig();
  final senhaCubit = SenhaCubit(checkPasswordConfig);

  group('Test SenhaCubit', () {
    test('Verificar Estado initial', () async {
      expect(senhaCubit.state, InitialSenhaStates());
    });

    blocTest<SenhaCubit, SenhaStates>('Senha foi igual digitada emite Sucesso',
        build: () => senhaCubit,
        act: (cubit) {
          when(checkPasswordConfig("12345"))
              .thenAnswer((_) => Future(() => true));
          cubit.checkPassword("12345");
        },
        expect: () => [
              SuccessSenhaStates(),
            ]);

    blocTest<SenhaCubit, SenhaStates>(
        'Senha foi diferente digitada emite Falha',
        build: () => senhaCubit,
        act: (cubit) {
          when(checkPasswordConfig("12345"))
              .thenAnswer((_) => Future(() => false));
          cubit.checkPassword("12345");
        },
        expect: () => [
              FailSenhaStates(),
            ]);
  });
}
