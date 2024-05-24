import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_cubit.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_states.dart';

import '../../../mock_usecases.mocks.dart';

void main() {
  final checkStatusUpdateDatabase = MockCheckStatusUpdateDatabase();
  final menuInicialCubit = MenuInicialCubit(checkStatusUpdateDatabase);

  group('Test MenuInicialCubit', () {
    test('Verificar Estado Initial', () async {
      expect(menuInicialCubit.state, InitialMenuInicialStates());
    });

    blocTest<MenuInicialCubit, MenuInicialStates>('Acesso liberado',
        build: () => menuInicialCubit,
        act: (cubit) {
          when(checkStatusUpdateDatabase())
              .thenAnswer((_) => Future(() => true));
          cubit.checkAccessApont();
        },
        expect: () => [
          AccessGrantedMenuInicialStates(),
        ]);

    blocTest<MenuInicialCubit, MenuInicialStates>('Acesso negado',
        build: () => menuInicialCubit,
        act: (cubit) {
          when(checkStatusUpdateDatabase())
              .thenAnswer((_) => Future(() => false));
          cubit.checkAccessApont();
        },
        expect: () => [
          AccessDeniedMenuInicialStates(),
        ]);
  });
}