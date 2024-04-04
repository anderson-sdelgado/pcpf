import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main(){
  final navigator = ModularNavigateMock();
  Modular.navigatorDelegate = navigator;

  test('navigation initial', (){
    when(() => navigator.navigate('/')).thenAnswer((_) => (){});
    verify(() => navigator.navigate('/')).called(1);
  });
}