import 'package:flutter_modular/flutter_modular.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/external/shared_preferences/config_datasource_shared_preferences_impl.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_datasource_shared_preferences.dart';
import 'package:pcp/infra/repositories/variable/config_repository_impl.dart';
import 'package:pcp/presenter/initial/config/config_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/senha_page.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance(LocalStorage());
    i.add<ConfigDatasourceSharedPreferences>(
        ConfigDatasourceSharedPreferencesImpl.new);
    i.add<ConfigRepository>(ConfigRepositoryImpl.new);
    i.add<CheckPasswordConfig>(CheckPasswordConfigImpl.new);
    i.add(SenhaCubit.new);
  }

  @override
  void routes(r) {
    r.child(URL_MENU_INICIAL, child: (_) => const MenuInicialPage());
    r.child(URL_SENHA, child: (_) => SenhaPage());
    r.child(URL_CONFIG, child: (_) => const ConfigPage());
  }
}

class LocalStorage {
  save(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString(key, value);
  }

  Future<String> get(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(key) ?? '';
  }
}
