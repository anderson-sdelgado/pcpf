import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/presenter/initial/senha/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/senha_states.dart';

import 'senha_cubit_test.mocks.dart';

@GenerateMocks([
  CheckPasswordConfig,
])
void main() {
  final checkPasswordConfig = MockCheckPasswordConfig();
  final senhaCubit = SenhaCubit(checkPasswordConfig);

  group('Test SenhaCubit', () {
    test('Verificar Estado initial', () async {
      expect(senhaCubit.state, InitialSenhaStates());
    });

    blocTest<SenhaCubit, SenhaStates>('Senha foi igual digitada emite Sucesso',
        build: () => senhaCubit,
        act: (bloc) {
          when(checkPasswordConfig("12345"))
              .thenAnswer((_) => Future(() => true));
          bloc.checkPassword("12345");
        },
        expect: () => [
              SuccessSenhaStates(),
            ]);

  });
}

