import 'package:flutter_modular/flutter_modular.dart';
import 'package:pcp/presenter/initial/menuinicial/menu_inicial_page.dart';

class AppModule extends Module {

  @override
  void bind(i) {

  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const MenuInicialPage());
  }

}